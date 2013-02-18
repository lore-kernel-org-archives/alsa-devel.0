From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Mon, 18 Feb 2013 23:20:03 +1030
Message-ID: <20130218125003.GC14697@marvin.atrad.com.au>
References: <20130113043936.GA8822@marvin.atrad.com.au>
 <s5h8v7xjw4f.wl%tiwai@suse.de>
 <20130210114707.GA26574@marvin.atrad.com.au>
 <s5hzjzbql3a.wl%tiwai@suse.de>
 <20130216112505.GE4164@marvin.atrad.com.au>
 <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjz2c1ui.wl%tiwai@suse.de>
 <s5h7gm6huq5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 426A6264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 13:50:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7gm6huq5.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

> > To confirm the behaviour: the "Headphone Jack Mode" control appears in
> > 3.8.0-rc5+ but a corresponding control for the mic/line-in jack does not.
> 
> Ah, I see.  This doesn't appear as default.  You need to pass a hint
> string in the firmware patch file.  See a brief description in
> Documentation/sound/alsa/HD-Audio.txt.

Right.  I'll take a look at this documentation.  I must say that it strikes
me as a little odd that input jacks don't have a mode control by default.  I
would have expected that such controls would be desired by enough people to
justify having them appear by default without each user having to mess
around with firmware patch files and the like.

I assume the magic knob is add_in_jack_modes.

Is there any reason why alc260_fixup_fsc_s7020() couldn't set
spec->gen.add_in_jack_modes to 1 in the HDA_FIXUP_ACT_PRE_PROBE phase much
like it already sets add_out_jack_modes?

On Mon, Feb 18, 2013 at 09:49:54AM +0100, Takashi Iwai wrote:
> > > > On Sun, Feb 17, 2013 at 09:32:38AM +0100, Takashi Iwai wrote:
> > > > > > I've been able to test this (snapshot as of two days ago, reports version
> > > > > > number 3.8.0-rc5+ via uname).  As expected there have been some
> > > > > > improvements.
> > > > > 
> > > > > Thanks for testing.
:
> > > > > > Things which don't work or are missing:
> > > > > > 
> > > > > >  * "Headphone Jack Mode" lacks options to enable various "mic" or "line in"
> > > > > >    modes (all of which are possible on this system)
> > > > > 
> > > > > Yes, it is still unimplemented.  So, it's expected not to be there
> > > > > yet.  If you can hack it by yourself, let me know.
> > > > 
> > > > I may be able to give this a go, but from what I recall there was some
> > > > debate as to how this should be implemented.  Has that been resolved yet?
> > > 
> > > No, we need to try to implement something and discuss later.
> > > I think simply implementing two things would work: providing the vref
> > > setup in Headphone Jack Mode enum, and add a pin to the Input Source.
> > > User would require two setups, but it's less conflicting with giving
> > > implicit dependency with each other, IMO.
> > > 
> > > > Is there any code I could use as a template or example?
> > > 
> > > No template, since the parser code has been completely rewritten
> > > recently.  Just take a look at hda_generic.c.
> > > 
> > > > > >  * The "Input source" controls don't offer the "headphone jack" as a
> > > > > >    possible source.
> > > > > 
> > > > > Ditto.
> > > > 
> > > > Ok.
> > > > 
> > > > > >  * The built-in speaker is completely silent under all situations I have
> > > > > >    come up with.  The setting of "Auto-Mute Mode" has no effect, neither
> > > > > >    does a manual unmute of the "Speaker" volume control.  While I don't
> > > > > >    personally care much about this I suspect others might.
> > > > > 
> > > > > Hm, this is really mysterious.  I have no idea which init code causes
> > > > > the problem, and it's hard to debug without a hardware.  Could you try
> > > > > to figure out which setup is missing?
> > > > 
> > > > I spent a quite some time on this using hda-verb tonight with no success.
> > > > I tried many combinations of mute settings and in the end unmuted every node
> > > > I can see which lies between the DAC (nid 0x2) and the speaker in this
> > > > laptop (nid 0x10).  That is:
> > > > 
> > > >  * Unmute the inputs on node 0x9
> > > >  * Maximise the volume on node 0x9
> > > >  * Unmute the input to node 0x10
> > > > 
> > > > Even with this the speakers remained mute.  I then tried using the relevant
> > > > parts of the S702X initialisation sequence from 3.3.5 but even this didn't
> > > > permit the speaker to make any sound.  Whatever's going on it's subtle.
> > > > 
> > > > I confirmed that the alsamixer "Speaker Volume" control manipulated the
> > > > output volume control of node 0x9 as it should.
> > > > 
> > > > A quick comparison of /proc/asound/card0/codec#0 from 3.3.5 (where the
> > > > speaker works) and 3.8.0-rc5+ (where it doesn't) failed to show anything
> > > > obvious.  A more detailed comparison may be required.
> > > 
> > > Hm, then maybe the default initialization verbs for ALC260 does
> > > something harmful for this machine?  A quick (untested) patch is
> > > below.
> > 
> > Oops, forgot got attach.
> 
> Scratch that.  It doesn't work as expected.
> Try the following one instead.

This latter patch appears to have improved things regarding the built-in
speaker.  With "Auto-Mute Mode" disabled:

 * The "Speaker" volume and mute controls in alsamixer now control the
   speaker in the expected way, and audio is emitted from the speaker.

 * The "Headphone" volume and speaker controls manipulate only the headphone
   volume (that is, "Headphone" and "Speaker" controls are independent).

 * "Master" affects both headphone and speaker volume (as it should)

If "Auto-Mute Mode" is enabled:

 * plugging headphones in automatically mutes the speaker

 * removing the headphone plug automatically unmutes the speaker

 * the headphone and speaker volume controls affect the relevant output

To summarise: this patch appears to make the speaker usable on the S7020
once more.

This then leaves the following to be resolved:

 * provision of an input jack mode control

 * ability to switch the headphone jack to mic/line input modes

 * inclusion of the headphone jack in the capture source lists

I will look into these along the lines of the hints given previous and
report back.

Regards
  jonathan

> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 48c9d10..e0e0a5a 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -1516,8 +1516,14 @@ static void alc260_fixup_fsc_s7020(struct hda_codec *codec,
>  {
>  	struct alc_spec *spec = codec->spec;
>  
> -	if (action == HDA_FIXUP_ACT_PRE_PROBE)
> +	switch (action) {
> +	case HDA_FIXUP_ACT_PRE_PROBE:
>  		spec->gen.add_out_jack_modes = 1;
> +		break;
> +	case HDA_FIXUP_ACT_PROBE:
> +		spec->init_amp = ALC_INIT_NONE;
> +		break;
> +	}
>  }
>  
>  static const struct hda_fixup alc260_fixups[] = {
