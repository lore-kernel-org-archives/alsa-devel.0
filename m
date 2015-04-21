From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Tue, 21 Apr 2015 13:43:47 +0100
Message-ID: <1429620227.3793.31.camel@loki>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk> <1429609673.3793.14.camel@loki>
 <s5hlhhlztnr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D9A2608ED
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 14:43:51 +0200 (CEST)
In-Reply-To: <s5hlhhlztnr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-04-21 at 12:02 +0200, Takashi Iwai wrote:
> At Tue, 21 Apr 2015 10:47:53 +0100,
> Liam Girdwood wrote:
> > 
> > On Mon, 2015-04-20 at 22:30 +0100, Mark Brown wrote:
> > > On Thu, Apr 16, 2015 at 09:48:15PM +0100, Liam Girdwood wrote:
> > > 
> > > > +struct snd_soc_tplg_hdr {
> > > > +	__le32 magic;
> > > > +	__le32 abi;		/* ABI version */
> > > > +	__le32 version;		/* optional vendor specific version details */
> > > > +	__le32 type;		/* SND_SOC_TPLG_ */
> > > > +	__le32 vendor_type;	/* optional vendor specific type info */
> > > > +	__le32 size;		/* data bytes, excluding this header */
> > > > +	__le32 id;		/* identifier for block */
> > > > +	char reserved[128];
> > > > +} __attribute__((packed));
> > > 
> > > Not got a massively strong opinion here but given that we have ABI
> > > versioning can we just skip the 128 bytes of reserved space in most of
> > > the structs?  Doesn't seem to be doing much except making the files
> > > bigger.
> > 
> > We had a similar discussion in Nuremburg last week, the intention is to
> > keep the size of the structures constant so wont dont break older
> > kernels with newer userspace ABIs etc.
> 
> Maybe a question is whether the size is sensible.  But the argument
> here was "memory is cheap nowadays".

Ok, we can reduce the size here. I think Vinod wanted at least 4 * 4
byte words (i.e. 16 bytes) minimum IIRC, what about 16 bytes ? That
would give us at least 4 new members for the future ?

> 
> 
> > > > +/*
> > > > + * Mixer kcontrol.
> > > > + */
> > > > +struct snd_soc_tplg_mixer_control {
> > > > +	struct snd_soc_tplg_control_hdr hdr;
> > > > +	__le32 min;
> > > > +	__le32 max;
> > > > +	__le32 platform_max;
> > > > +	__le32 reg;
> > > > +	__le32 rreg;
> > > > +	__le32 shift;
> > > > +	__le32 rshift;
> > > 
> > > Do we want to convert this into an array of reg/shift tuples for the
> > > (dobutless forthcoming) 5.1 controls?  Not sure it's worth it.  I do
> > > think we probably need some explicit documentation for things like what
> > > to do with the left and right bits, I guess we hope other OSs or
> > > whatever can make use of the same topology if we're trying to make it
> > > standard.
> > 
> > Yeah, that's a good point which we should address :)
> > 
> > What about something like :-
> > 
> > struct snd_soc_mixer_channel {
> > 	__le32 reg;
> > 	__le32 shift;
> > }
> > 
> > struct snd_soc_tplg_mixer_control {
> > 	struct snd_soc_tplg_control_hdr hdr;
> > 	__le32 min;
> > 	__le32 max;
> > 	__le32 platform_max;
> > 	__le32 invert;
> > 	__le32 num_channels;
> > 	char reserved[64];
> > 	struct snd_soc_tplg_mixer_channel channel[0];
> > 	struct snd_soc_tplg_private priv;
> 
> A field after a variable array doesn't work.  Either drop priv or make
> channel a fixed size array (with some max).

Oh I did not try and build this ;) A fixed size works for me. What about
8 channels (meaning we support upto 7.1) ? 

Another thing that comes to mind is should we also include some channel
mapping data ?

struct snd_soc_mixer_channel {
	__le32 map;	/* Maps to ID for Left, Right, LFE etc */
	__le32 reg;
	__le32 shift;
}

Liam
