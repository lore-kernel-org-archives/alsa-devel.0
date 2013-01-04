From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Fri, 4 Jan 2013 12:15:42 +0800
Message-ID: <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f178.google.com (mail-ia0-f178.google.com
 [209.85.210.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 572182616A0
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 05:15:43 +0100 (CET)
Received: by mail-ia0-f178.google.com with SMTP id k25so13322850iah.37
 for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2013 20:15:42 -0800 (PST)
In-Reply-To: <20130104032449.GA15708@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > > Having been running kernel 3.3.5 for a while, I decided to upgrade
to 3.7.1
> > > > tonight.  Unfortunately there have been a number of HDA-related
regressions
> > > > between these two kernels when running on a Fujitsu S7020 laptop
which are
> > > > clearly related to the HDA rewrite which has been going on
recently. This
> > > > laptop utilises the Realtek ALC260 codec.
> > > > :
> > > > Under 3.3.5, sound works perfectly.
> > > >
> > > > Under 3.7.1 there are a number of regressions:
> >
> > If is because the commit remove the Fujitsu model
> >
> >
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=c29b3f6dd7798964d77199af4925be72a3a48349;hp=b1f58085a9c01e8ffab954fd77a45f1143edf34d
> >
> > The driver need pin fixup  for the internal speaker and change the pin
> > default of following node to [N/A]
> >
> > Node 0x13 [Jack] Line In at Sep Right
> > Node 0x17 [Fixed] Aux at Oth Mobile-In
> >
> > -/* Initialisation sequence for ALC260 as configured in Fujitsu S702x
> > - * laptops.  ALC260 pin usage: Mic/Line jack = 0x12, HP jack = 0x14, CD
> > - * audio = 0x16, internal speaker = 0x10.
> > - */
> > -static const struct hda_verb alc260_fujitsu_ini
> >
> > Do the notebook really use node 0x16 CD ?
>
> Yes.  That's where the CD audio comes in.
>

How about those HP and Mic of the port replicator ?

If also affect LIFEBOOK E8020

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868
