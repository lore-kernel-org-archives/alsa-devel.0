From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Mon, 29 Mar 2010 09:10:14 +0800
Message-ID: <4f3252891003281810r38e61306w83ebfe9ad2b8c69f@mail.gmail.com>
References: <hm5aba$p65$1@dough.gmane.org> <hm5u2i$2h7$1@dough.gmane.org>
	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>
	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>
	<hm8cus$56i$1@dough.gmane.org>
	<1267193154.29204.0.camel@localhost.localdomain>
	<4f3252891002271729p6eb66724v62ce97ea9a6eb577@mail.gmail.com>
	<hohr62$f78$1@dough.gmane.org>
	<4f3252891003280552y29015aeav7b68e9972371325b@mail.gmail.com>
	<hooi7i$fd4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 82C871037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 03:10:15 +0200 (CEST)
Received: by pwj7 with SMTP id 7so7001744pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 18:10:14 -0700 (PDT)
In-Reply-To: <hooi7i$fd4$1@dough.gmane.org>
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

2010/3/29 Angel Tsankov <fn42551@fmi.uni-sofia.bg>

> Raymond Yau wrote:
> > 2010/3/26 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
> >
> >> Hello again!
> >>
> >> I've recently had some time to investigate this problem further on and
> >> here's what I've discovered:
> >>
> >> Raymond Yau wrote:
> >>> 2010/2/26 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
> >>>
> >>>> El vie, 26-02-2010 a las 13:57 +0200, Angel Tsankov escribi=F3:
> >>>>> Raymond Yau wrote:
> >>>>>> 2010/2/25 Jaroslav Kysela <perex@perex.cz>
> >>>>>>
> >>>>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> >>>>>>>
> >>>>>>>> Jaroslav Kysela wrote:
> >>>>>>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> >>>>>>>>>
> >>>>>>>>>> Hello,
> >>>>>>>>>>
> >>>>>>>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a
> >>>> built-in
> >>>>>>>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controll=
er
> >>>> (rev
> >>>>>>>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
> >>>>>>>>>> Controller] (rev 03) -- and get the following message:
> >>>>>>>>>>
> >>>>>>>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84"
> >>>> "AC97a:83847600"
> >>>>>>>>>> "0x1073" "0x000d"
> >>>>>>>>>> Hardware is initialized using a guess method
> >>>>>>>>>>
> >>>>>>>>>> As a consequence the volume levels of the Yamaha card do not g=
et
> >>>>>>>>>> restored to the levels stored in /etc/asound.state.  The volume
> >>>> levels
> >>>>>>>>>> of the built-in card however are properly restored.  The
> >>>> asound.state
> >>>>>>>>>> file has been created by executing 'alsactl store'.
> >>>>>>>>>>
> >>> your problem is "alsactl restore" become "alsactl init" when the numb=
er
> >> of
> >>> controls is more than those in state file.
> >> I'm not quite sure that the case is this since 'alsactl restore' does
> >> restore the values of the Yamaha sound card (and those of the other
> >> card, too) and 'alsactl restore 1' seems to just initialize the Yamaha
> >> card.  This is with alsa-utils version 1.0.22.
> >>
> > "Hardware is initialized using a guess method "  is the message used by
> > alsactl init
> >
> >
> http://git.alsa-project.org/?p=3Dalsa-utils.git;a=3Dcommitdiff;h=3D9a7481=
78d1c9e783242f0cc794ab3efb27092f34;hp=3D0c02a4e3d23c7b5d03215f1bfaba9f70ed1=
1e9b7
>
> I don't get what you mean. Could you explain a little bit more?
>
>
> Regards,
> Angel Tsankov
>
>
post the output of alsa-info.sh after  "alsactl init"

and immeditate after the system boot
