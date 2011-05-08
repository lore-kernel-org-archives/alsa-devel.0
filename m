From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Sun, 8 May 2011 14:40:36 +0800
Message-ID: <BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A506C1037F3
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 08:40:37 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3504533fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 07 May 2011 23:40:36 -0700 (PDT)
In-Reply-To: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
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

2011/5/8 alex dot baldacchino dot alsasub at gmail dot com <
alex.baldacchino.alsasub@gmail.com>

>
>
> Notice also line "hda-codec: no NID for mapping control Independent
> HP:0:0".
> That's because function
>
> 'snd_hda_get_connections'      (patch_via.c)
>
> called by
>
> 'via_hp_build'
>
> returns 3 ( test for 'nums <= 1' fails and the function doesn't return),
> but function
>
> 'side_mute_channel',
>
> called to init knew->subdevice when 'registering' via_hp_mixer[1], returns
> 0
> (default value) and so condition 'if(nid > 0)', in function
>
> 'snd_hda_add_nid'      (hda_codec.c),
>
> is not met and the error is triggered (by the way, param nid is of type
> hda_nid_t which in turn is an unsigned integer (u16), so, should that be
> 'if(nid != 0)' instead? just to avoid the risk of giving the impression
> that
> negative values are possible but mistaken (hda_nid_t is defined elsewhere).
> Also: param @nid, in function
> comment/documentation is defined as optional, but it doesn't seem to be).
> Incidentally, in /proc/asound/card0/codec#0 node 0x35 looks much like node
> 0x34 (with both older and newer kernel; posting excerpt for kernel
> 2.6.38.3):
>
> Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
> Control: name="Independent HP", index=0, device=0
> Power states: D0 D1 D2 D3
> Power: setting=D0, actual=D0
> Connection: 3
> 0x08 0x0b 0x0c*
> Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
> Power states: D0 D1 D2 D3
> Power: setting=D0, actual=D0
> Connection: 3
> 0x08 0x0b* 0x0c
>
> (notice connections and wcaps similarity, if relevant at all)
>
> Since I'm quite crazy, I've tried to modify 'side_mute_channel' to have it
> returning '0x35' for codec type 'VT1718S', but to no avail; I also tried to
> bypass 'snd_hda_add_nid', both avoiding 'via_hp_build' to clone
> via_hp_mixer[<something>] and/or modifying 'via_build_controls' and
> 'snd_hda_add_new_ctls' (hda_control.c) so
> that "Independent HP" ctls were handled by the latter (achieving this was
> just
> a matter of a pair of strcmp's to choose skipping the rest of an
> iteration or not),
> as I deem it was done in alsa 1.0.21 (embedded in kernel 2.6.33.2),
> but it didn't
> work (the only result I got this ways was to avoid that error message about
> nids
> in system logs).
>
>
Try the snapshot tarballs or git at

http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/HD-Audio.html

Post the output of alsa-info.sh

What is the model of your computer (desktop/notebook) ?

How many audio jacks ?

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/729659

It seem that vt2020 is 10 channels HDA with 5 [Audio Output] 0x8, 0x9, 0xa,
0xb and 0xc
