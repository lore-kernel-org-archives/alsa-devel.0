From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio generic parser merged to linux-next
Date: Mon, 11 Feb 2013 23:12:16 +0800
Message-ID: <CAN8cciZEWHHKLAq-tqpA7G5GiH-tCX9bgbGdEdzsUAu=jkhrpg@mail.gmail.com>
References: <s5hbocg1etr.wl%tiwai@suse.de>
 <CAN8ccia4vHek6n5xZi26nNZV0wmzv3H6cBjP4q+UTi3ubyTHSw@mail.gmail.com>
 <s5hpq07orhe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B5412602AD
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 16:12:17 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id k14so7691737iea.41
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 07:12:17 -0800 (PST)
In-Reply-To: <s5hpq07orhe.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> > >
> > > If you encounter any regression by the recent update, please let me
> > > know.
> > >
> >
> > Refer to commit 657e1b931d42882cb0a59b599247bef696c22406
> >
> > ALSA: hda - Select auto-parser as default for AD codecs
> >
> > it seem that independent hp is enabled on AD1986A which does not support
> > indepedent headphone
>
> AD1986A can send an individual stream to HP.
>
> The pin 0x1a takes the selector 0x0a, which can choose either the
> mixer widget 0x07 or a DAC (0x04).
>

6 DAC channels for 5.1 surround

Can independent headphone enabled by default since this mean that lost of
surround 5.1 for those desktop with three audio jacks at rear panel ?
