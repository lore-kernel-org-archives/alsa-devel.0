From: John Frankish <john.frankish@outlook.com>
Subject: Re: No sound from speakers with Realtek ALC3226
Date: Wed, 25 Feb 2015 15:56:23 +0400
Message-ID: <COL403-EAS2438446363B47C43DAA04A4F3170@phx.gbl>
References: <COL403-EAS144CB85A708197E0DF2965FF3160@phx.gbl>
 <s5h61are4m2.wl-tiwai@suse.de>
 <COL403-EAS2907AF9B8908D92F837F8E5F3170@phx.gbl>
 <s5h4mqa5p3c.wl-tiwai@suse.de>
 <COL403-EAS2576E554CAD96126742849BF3170@phx.gbl>
 <s5hioeqcm89.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC3S6.hotmail.com (col004-omc3s6.hotmail.com
 [65.55.34.144]) by alsa0.perex.cz (Postfix) with ESMTP id 17DE126052A
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 12:56:32 +0100 (CET)
In-Reply-To: <s5hioeqcm89.wl-tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: 'Takashi Iwai' <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > > > > > I posted this on the alsa-user list, but did not get a reply.
> > > > > > 
> > > > > > Although it occasionally works, I am usually unable to get any 
> > > > > > sound out of the speakers on a dell latitude e7240 using
> > > > > > alsa-1.0.28 and
> > > > > > linux-3.16.6 - see details at the end of the post.
> > > > >
> > > > > If so, Windows or BIOS is the problem.  It doesn't set up the 
> > > > > pin configuration properly Linux driver relies on.
> > > > >
> > > > I just updated the bios to the latest version, but no change :(
> > > > >
> > I'd rather patch my current kernel if possible - do you know where the 
> > EPAD control patch is by any chance?
>
> Look through git log of sound/pci/hda/patch_realtek.c.  But beware that
the patches won't be applied cleanly; otherwise I would have marked them for
stable.
>
> But I'll ask for testing with the newer kernels in anyway if patching
fails, so...
>
Thanks

The first hunk of the patch applies cleanly, but...

  CC [M]  sound/pci/hda/patch_realtek.o
sound/pci/hda/patch_realtek.c: In function 'alc_fill_eapd_coef':
sound/pci/hda/patch_realtek.c:234:2: error: implicit declaration of function
'alc_get_coef0' [-Werror=implicit-function-declaration]
  coef = alc_get_coef0(codec);
  ^
sound/pci/hda/patch_realtek.c:238:2: error: implicit declaration of function
'alc_update_coef_idx' [-Werror=implicit-function-declaration]
  alc_update_coef_idx(codec, 0x7, 0, 1<<5);
  ^
sound/pci/hda/patch_realtek.c: At top level:
sound/pci/hda/patch_realtek.c:695:21: error: conflicting types for
'alc_get_coef0'
 static unsigned int alc_get_coef0(struct hda_codec *codec)
                     ^
sound/pci/hda/patch_realtek.c:234:9: note: previous implicit declaration of
'alc_get_coef0' was here
  coef = alc_get_coef0(codec);
         ^
sound/pci/hda/patch_realtek.c:230:13: warning: 'alc_fill_eapd_coef' defined
but not used [-Wunused-function]
 static void alc_fill_eapd_coef(struct hda_codec *codec)
             ^
cc1: warning: unrecognized command line option "-Wno-errors"
cc1: some warnings being treated as errors
scripts/Makefile.build:257: recipe for target
'sound/pci/hda/patch_realtek.o' failed
make[1]: *** [sound/pci/hda/patch_realtek.o] Error 1
Makefile:1333: recipe for target '_module_sound/pci/hda' failed
make: *** [_module_sound/pci/hda] Error 2
