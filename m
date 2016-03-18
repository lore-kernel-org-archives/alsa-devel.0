From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: New snd-hda warning spew
Date: Fri, 18 Mar 2016 21:27:54 +0200
Message-ID: <20160318192754.GV4329@intel.com>
References: <20160315160207.GY4329@intel.com> <s5hio0nejv3.wl-tiwai@suse.de>
 <20160316140420.GB4329@intel.com> <20160318135459.GF4329@intel.com>
 <s5hwpoz50iw.wl-tiwai@suse.de> <20160318174919.GR4329@intel.com>
 <s5ha8lvvcu8.wl-tiwai@suse.de> <20160318191058.GU4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D4FD264FF6
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 20:28:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160318191058.GU4329@intel.com>
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
Cc: alsa-devel@alsa-project.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 09:10:58PM +0200, Ville Syrj=E4l=E4 wrote:
> On Fri, Mar 18, 2016 at 07:51:43PM +0100, Takashi Iwai wrote:
> > On Fri, 18 Mar 2016 18:49:19 +0100,
> > Ville Syrj=E4l=E4 wrote:
> > > =

> > > On Fri, Mar 18, 2016 at 03:22:15PM +0100, Takashi Iwai wrote:
> > > > On Fri, 18 Mar 2016 14:54:59 +0100,
> > > > Ville Syrj=E4l=E4 wrote:
> > > > > =

> > > > > On Wed, Mar 16, 2016 at 04:04:20PM +0200, Ville Syrj=E4l=E4 wrote:
> > > > > > On Tue, Mar 15, 2016 at 06:22:56PM +0100, Takashi Iwai wrote:
> > > > > > > On Tue, 15 Mar 2016 17:02:07 +0100,
> > > > > > > Ville Syrj=E4l=E4 wrote:
> > > > > > > > =

> > > > > > > > We have a few new WARN spews from snd-hda causing some grie=
f in i915 CI.
> > > > > > > > =

> > > > > > > > This one happens on ILK and BYT. Looks like it happens 100%=
 of the time on driver load:
> > > > > > > > [   18.809850] ------------[ cut here ]------------
> > > > > > > > [   18.809866] WARNING: CPU: 0 PID: 39 at sound/hda/hdac_i9=
15.c:129 pin2port+0x25/0x30 [snd_hda_core]()
> > > > > > > =

> > > > > > > This is bad.  Basically we had a naive assumption of the fixe=
d mapping
> > > > > > > between the port number and the HD-audio widget, but it doesn=
't apply
> > > > > > > properly to pre-HSW models.
> > > > > > > =

> > > > > > > The patch attached below disables the audio binding for pre-H=
SW
> > > > > > > models.  I'm going to queue to for-linus branch.
> > > > > > =

> > > > > > That seems to eliminate the warn on my ILK.
> > > > > =

> > > > > Apparently it was less effective on BYT. We still get this:
> > > > =

> > > > Ouch, I forgot that Baytrail had already i915 component binding in =
the
> > > > controller side.  I assumed too naively that all old models have no
> > > > binding.
> > > > =

> > > > Below is the additional fix patch.
> > > =

> > > Still getting blasted at least via snd_hdac_sync_audio_rate()
> > =

> > That code path is a slightly different.  This is a kind of false
> > positive, but now the function checks the validity of the passed
> > argument more strictly, and starts grumbling.
> > =

> > The fix is attached below.
> > =

> > =

> > Takashi
> > =

> > -- 8< --
> > From: Takashi Iwai <tiwai@suse.de>
> > Subject: [PATCH] ALSA: hda - Fix spurious kernel WARNING on Baytrail HD=
MI
> > =

> > snd_hdac_sync_audio_rate() call is mandatory only for HSW and later
> > models, but we call the function unconditionally blindly assuming that
> > the function doesn't do anything harmful.  But since recently, the
> > function checks the validity of the passed pin NID, and eventually
> > spews the warning if an unexpected pin is passed.  This is seen on old
> > chips like Baytrail.
> > =

> > The fix is to limit the call of this function again only for the chips
> > with the proper binding.  This can be identified by the same flag as
> > the eld notifier.
> > =

> > Reported-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > Cc: <stable@vger.kernel.org> # v4.5
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > =

> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index e7d9453ecd10..56d3575ee6cc 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1741,7 +1741,8 @@ static int generic_hdmi_playback_pcm_prepare(stru=
ct hda_pcm_stream *hinfo,
> >  =

> >  	/* Call sync_audio_rate to set the N/CTS/M manually if necessary */
> >  	/* Todo: add DP1.2 MST audio support later */
> > -	snd_hdac_sync_audio_rate(&codec->bus->core, pin_nid, runtime->rate);
> > +	if (codec_has_acomp(codec))
> > +		snd_hdac_sync_audio_rate(&codec->bus->core, pin_nid, runtime->rate);
> =

> Yeah seems like it should do it.

Yep, didn't see any more backtraces in the logs with this one.
Tested-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>

> =

> Though I'm not entirely enthusiastic about maintaining two code paths
> for audio stuff. So longer term I'd love to be able rip out the
> hardware based ELD passing from i915 and just use the audio component
> even for the oldest platforms.
> =

> >  =

> >  	non_pcm =3D check_non_pcm_per_cvt(codec, cvt_nid);
> >  	mutex_lock(&per_pin->lock);
> > -- =

> > 2.7.4
> =

> -- =

> Ville Syrj=E4l=E4
> Intel OTC

-- =

Ville Syrj=E4l=E4
Intel OTC
