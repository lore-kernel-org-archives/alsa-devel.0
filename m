From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Tue, 21 Apr 2015 10:47:53 +0100
Message-ID: <1429609673.3793.14.camel@loki>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9693A26069D
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 11:47:58 +0200 (CEST)
In-Reply-To: <20150420213048.GT14892@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-04-20 at 22:30 +0100, Mark Brown wrote:
> On Thu, Apr 16, 2015 at 09:48:15PM +0100, Liam Girdwood wrote:
> 
> > +struct snd_soc_tplg_hdr {
> > +	__le32 magic;
> > +	__le32 abi;		/* ABI version */
> > +	__le32 version;		/* optional vendor specific version details */
> > +	__le32 type;		/* SND_SOC_TPLG_ */
> > +	__le32 vendor_type;	/* optional vendor specific type info */
> > +	__le32 size;		/* data bytes, excluding this header */
> > +	__le32 id;		/* identifier for block */
> > +	char reserved[128];
> > +} __attribute__((packed));
> 
> Not got a massively strong opinion here but given that we have ABI
> versioning can we just skip the 128 bytes of reserved space in most of
> the structs?  Doesn't seem to be doing much except making the files
> bigger.

We had a similar discussion in Nuremburg last week, the intention is to
keep the size of the structures constant so wont dont break older
kernels with newer userspace ABIs etc.

> 
> > +/*
> > + * Mixer kcontrol.
> > + */
> > +struct snd_soc_tplg_mixer_control {
> > +	struct snd_soc_tplg_control_hdr hdr;
> > +	__le32 min;
> > +	__le32 max;
> > +	__le32 platform_max;
> > +	__le32 reg;
> > +	__le32 rreg;
> > +	__le32 shift;
> > +	__le32 rshift;
> 
> Do we want to convert this into an array of reg/shift tuples for the
> (dobutless forthcoming) 5.1 controls?  Not sure it's worth it.  I do
> think we probably need some explicit documentation for things like what
> to do with the left and right bits, I guess we hope other OSs or
> whatever can make use of the same topology if we're trying to make it
> standard.

Yeah, that's a good point which we should address :)

What about something like :-

struct snd_soc_mixer_channel {
	__le32 reg;
	__le32 shift;
}

struct snd_soc_tplg_mixer_control {
	struct snd_soc_tplg_control_hdr hdr;
	__le32 min;
	__le32 max;
	__le32 platform_max;
	__le32 invert;
	__le32 num_channels;
	char reserved[64];
	struct snd_soc_tplg_mixer_channel channel[0];
	struct snd_soc_tplg_private priv;
} __attribute__((packed));

The same could be applied to the other control types too ?

Liam

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
