From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v2 6/6] ASoC: hdmi-codec: Use HDMI
 notifications to add jack support
Date: Fri, 8 Jan 2016 10:46:23 +0000
Message-ID: <20160108104623.GF19062@n2100.arm.linux.org.uk>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
 <1451935145-24861-1-git-send-email-p.zabel@pengutronix.de>
 <568E9BE1.6050209@ti.com> <1452242629.3347.12.camel@pengutronix.de>
 <568F87F7.3010409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 7851A26040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 11:46:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <568F87F7.3010409@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 08, 2016 at 11:57:11AM +0200, Jyri Sarha wrote:
> On 01/08/16 10:43, Philipp Zabel wrote:
> >Possibly the HDMI driver itself should just mute if the format is not
> >supported, and userspace should be notified?
> 
> Another option would be simply aborting the playback. However having a mute
> control, that is forced to mute if the current stream is not supported, is
> an interesting idea. That would provide a way to notify the userspace
> without intrusively killing the stream.

Firstly, remember that the sequence you'll likely see is:

- disconnect
- connect
- new edid
- new eld

The disconnect/connect cycle is HDMI protocol for "please re-read
the EDID" and is used (eg) by AV receivers to signal a change.  When
they change from HDMI pass-through mode in standby, to being powered
on, they typically switch from passing the displays EDID through
unmodified, to a modified version with their audio capabilities
included - and vice versa when they're placed back into standby.

The kernel's audio driver doesn't have any knowledge about the kind
of audio being passed through it: while it knows the alleged sample
rate, bits per sample, and number of channels, these are PCM details,
and not compressed audio details.  Compressed audio is normally sent
with the kernel driver configured for 16 bit, 2 channel and an
appropriate sample rate, with the IEC958 channel status data setup
by the application (via libasound) to indicate non-audio amongst
other details.  Therefore, the kernel driver doesn't know a
nature of the compressed audio stream, and can't "mute" the stream
if the ELD indicates that the compressed audio stream has gone
away.

Given that, I'd like to throw in here another detail: iirc, i915's
HDMI exports the ELD to userspace via a control called "ELD" - see
eld_bytes_ctl in sound/pci/hda/patch_hdmi.c.  This allows userspace
to monitor, and read the ELD including which compressed audio formats
are supported.  I'm not currently aware of anything that makes use of
this, but as there is this precedent for exporting this information,
maybe it should become a standard way, so that video playback
applications can then select an appropriate audio stream depending on
the current properties of the connected device?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
