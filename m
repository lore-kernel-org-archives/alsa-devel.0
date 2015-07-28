From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v13 3/3] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Tue, 28 Jul 2015 15:18:42 +0100
Message-ID: <20150728141842.GL7557@n2100.arm.linux.org.uk>
References: <cover.1437397270.git.moinejf@free.fr>
 <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf@free.fr>
 <20150720180606.GL11162@sirena.org.uk>
 <20150728121945.560f82a5@armhf>
 <20150728102410.GD11162@sirena.org.uk>
 <20150728152329.02668865@armhf>
 <20150728135358.GK7557@n2100.arm.linux.org.uk>
 <s5hio94tmb2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hio94tmb2.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 28, 2015 at 03:59:45PM +0200, Takashi Iwai wrote:
> FWIW, we're currently discussing about extending the i915/hda
> component binding so that the audio driver gets a notification and
> queries the ELD via callbacks instead of the flaky hardware access.
> 
> It'd be best if we have a common infrastructure for that, of course.
> But currently it's a start, just a bit step forward there.

Okay, so it sounds like i915/hda also needs this.

I think in addition to what I said above, we need whatever provides the
notification system to generate state notifications for new "listeners"
that would otherwise be unaware of the current state.

I'm thinking at the moment that something along these lines to go into
drivers/video/hdmi.c / include/linux/hdmi.h:

struct hdmi_state {
	struct mutex mutex;
	struct raw_notifier_head head;
	bool connected;
	bool edid_valid;
	u8 edid[MAX_EDID_SIZE];
};

enum {
	HDMI_CONNECTED,
	HDMI_DISCONNECTED,
	HDMI_NEW_EDID,
};

int hdmi_register_notifier(struct notifier_block *nb)
{
	struct hdmi_state *state = ...;
	int ret;

	mutex_lock(&state->mutex);
	if (state->connected) {
		nb->notifier_call(nb, HDMI_CONNECTED, NULL);
		if (state->edid_valid)
			nb->notifier_call(nb, HDMI_NEW_EDID, state->edid);
	} else {
		nb->notifier_call(nb, HDMI_DISCONNECTED, NULL);
	}
	ret = raw_notifier_chain_register(&state->head, nb);
	mutex_unlock(&state->mutex);

	return ret;
}

int hdmi_unregister_notifier(struct notifier_block *nb)
{
	struct hdmi_state *state = ...;
	int ret;

	mutex_lock(&state->mutex);
	ret = raw_notifier_chain_unregister(&state->head, nb);
	mutex_unlock(&state->mutex);

	return ret;
}

void hdmi_event_connect(struct device *dev)
{
	struct hdmi_state *state = lookup_state_from_dev(dev);

	mutex_lock(&state->mutex);
	state->connected = true;
	raw_notifier_call_chain(&state->head, HDMI_CONNECTED, NULL);
	mutex_unlock(&state->mutex);
}

void hdmi_event_disconnect(struct device *dev)
{
	struct hdmi_state *state = lookup_state_from_dev(dev);

	mutex_lock(&state->mutex);
	state->connected = false;
	state->valid_edid = false;
	raw_notifier_call_chain(&state->head, HDMI_DISCONNECTED, NULL);
	mutex_unlock(&state->mutex);
}

int hdmi_event_new_edid(struct device *dev, const void *edid, size_t size)
{
	struct hdmi_state *state = lookup_state_from_dev(dev);

	if (size > sizeof(state->edid))
		return -EINVAL;

	mutex_lock(&state->mutex);
	state->valid_edid = true;
	memcpy(state->edid, edid, size);
	raw_notifier_call_chain(&state->head, HDMI_NEW_EDID, state->edid);
	mutex_unlock(&state->mutex);

	return 0;
}

The problems here are: how to go from a struct device to the state (iow,
the implementation of lookup_state_from_dev()) and how to convey on the
client side which 'state' to attach to.  I'd rather not involve DT at
this level: DT is not the world's only firmware system, we have to cater
for x86 too here, so we need something that is firmware agnostic.

This is something I've just banged out in this email...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
