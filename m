From: John Frankish <john.frankish@outlook.com>
Subject: Re: Intel alsa sound request for Laptops
Date: Sat, 28 Jan 2017 16:54:29 +0000
Message-ID: <DBXPR04MB334D7AB20A0F4C15ADD0CB2F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
References: <DBXPR04MB334548B939F29F8E6E24790F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hwpdf9nzt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SNT004-OMC3S31.hotmail.com (snt004-omc3s31.hotmail.com
 [65.55.90.170]) by alsa0.perex.cz (Postfix) with ESMTP id F111A266652
 for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2017 17:54:32 +0100 (CET)
In-Reply-To: <s5hwpdf9nzt.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > For two or three kernel versions of alsa divers now, HDMI has been the default alsa device on my
> > laptop (Dell Latitude E7240) - this does not make logical sense.
> >
> > In the latest kernel version I use, 4.2.9, alsa sound will not work at all unless I load the i915 kernel driver
> > - this does not make logical sense and means that I cannot use Xvesa.
> >
> > Is it possible to make an alsa feature request for analogue sound to be the default alsa device on
> > laptops and for alsa sound to work without the need to load the i915 kernel driver?
> >
> It's a configuration issue.  Pass the module option if you prefer the secondary device:
> 
> options snd-hda-intel index=1,0
> 
Sure, I realise I can do that, but it's not the point and it's awkward to do so with the "live CD-type" distro I use (tinycorelinux).

Laptop sound should work in standalone mode by default - i.e. if laptop uses analogue sound for its built-in speakers then the alsa default should be analogue sound.

The above notwithstanding, analogue sound should work without needing to load the i915 kernel driver.
