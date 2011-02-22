From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix mic initialization in VIA
 auto parser (was: pci/hda/patch_via.c - broken between 2.6.36 and 2.6.37
 (bisected))
Date: Tue, 22 Feb 2011 20:13:09 +0800
Message-ID: <AANLkTikjFG__uTqFRBmhqXuUbgNfuckv+_NMe-6S205Q@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<4D6223CD.4060900@canonical.com>
	<AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
	<4D62308E.8070606@canonical.com> <ik066p$5li$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A8B10103854
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 13:13:13 +0100 (CET)
Received: by ewy19 with SMTP id 19so156437ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 04:13:09 -0800 (PST)
In-Reply-To: <ik066p$5li$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/22 Wolfgang Scheicher <wolfgang.scheicher@gmail.com>

> David Henningsson wrote:
>
> > On 2011-02-21 09:43, Mark Goldstein wrote:
> >> [...]
> >>
> >> I've never dealt with submitting patches, so probably it'll be better
> >> (and definitely faster) if you could do it.
> >>
> >> Thank you,
> >
> > Ok, here comes the patch!
>
> Tested, and Microphone now works! Thanks a lot to everyone involved.
> Good job so far!
>
> On a side note:
> One still must not touch "Smart 5.1" in alsamixer, because if one does,
> mixer will still crash and (sound)system will hang until pc is rebooted.
> I can't tell how related this two problems are, but as far as i can tell
> they both appeared with the same commit
> ( 7b315bb4980448250c80a7464c256b54d546cb26 ) i did track down on sunday.
>
> Wolfgang Scheicher
>

This will disable the creation of smart51 switch for those non 3-jacks model

static int via_smart51_build(struct via_spec *spec)
{
    struct snd_kcontrol_new *knew;
    const struct auto_pin_cfg *cfg = &spec->autocfg;
    hda_nid_t nid;
    int i;
+        if (spec->autocfg.line_outs != 1) {
+        spec->smart51_enabled=0;
+       return 0;
+     }
