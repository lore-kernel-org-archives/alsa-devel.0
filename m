From: Felix Rauscher <felixrauscher@alice-dsl.net>
Subject: Re:
	=?iso-8859-1?q?Noise_on_rear_speaker_when_switching_?=
	=?iso-8859-1?q?from_2=2E0_to_5=2E1=09sound?=
Date: Tue, 7 Aug 2007 22:10:59 +0200
Message-ID: <200708072210.59171.felixrauscher@alice-dsl.net>
References: <200708042019.04441.felixrauscher@alice-dsl.net>
	<s5hir7sq31h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out01.alice-dsl.net (smtp-out01.alice-dsl.net
	[88.44.60.11]) by alsa0.perex.cz (Postfix) with ESMTP id C1E2E10390A
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Aug 2007 22:11:01 +0200 (CEST)
In-Reply-To: <s5hir7sq31h.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi

the output of

cat /proc/asound/card0/cmipci

when thwe rear channels are noisy is:

C-Media PCI CMI8738-MC6 (model 55) at 0x9400, irq 22

00: 00 00 02 00
04: 14 fc 00 00
08: 0f 00 09 80
0c: 00 00 02 0a
10: 80 00 00 00
14: 00 80 00 80
18: a0 80 c0 0a
1c: 00 00 ee ee
20: 10 40 f8 00
24: 02 3e ff 00
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00

after restarting the vdr-xineliboutput client the rear channels were ok. Then 
the output was

C-Media PCI CMI8738-MC6 (model 55) at 0x9400, irq 22

00: 00 00 02 00
04: 14 fc 00 00
08: 0f 00 09 80
0c: 00 00 02 0a
10: 80 00 00 00
14: 00 80 00 80
18: a0 80 c0 0a
1c: 00 00 ee ee
20: 10 40 f9 00
24: 02 3e ff 00
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00

A diff off these outputs found als only difference the line starting 
with '20:'.

In advance, thank you for your help!

Felix



On Monday 06 August 2007 14:07:54 you wrote:
> At Sat, 4 Aug 2007 20:19:04 +0200,
>
> Felix Rauscher wrote:
> > Hello,
> >
> > I have a Hercules Muse 5.1 DVD (C-Media PCI CMI8738-MC6). I have a
> > problem when a running xine (e.g xineliboutput from vdr) switches from
> > 2.0 to 5.1 output. Then the sound quality of the rear speakers is
> > terrible. There is a noise on the rear speakers.
> >
> > If I start the xineliboutput-client when vdr already plays a programme
> > with a 5.1 sound track, the quality is ok. It looks like the switching
> > between 2.0 to 5.1 is a problem.
>
> So far, I have no clue what could be wrong there.
> Maybe you can see significant difference in /proc/asound/card0/cmipci
> proc file between the working and the non-working states.
>
>
> Takashi
