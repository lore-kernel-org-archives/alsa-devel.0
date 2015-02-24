From: Alnie <alnieb@yahoo.com>
Subject: Re: Issues w/ Creative Labs [SB
	X-Fi	Xtreme	Audio]	CA0110-IBG
Date: Tue, 24 Feb 2015 21:30:27 +0000 (UTC)
Message-ID: <1471037060.5415741.1424813427312.JavaMail.yahoo@mail.yahoo.com>
References: <s5h4mqb6o2x.wl-tiwai@suse.de>
Reply-To: Alnie <alnieb@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm13-vm4.bullet.mail.ne1.yahoo.com
 (nm13-vm4.bullet.mail.ne1.yahoo.com [98.138.91.173])
 by alsa0.perex.cz (Postfix) with ESMTP id EDC3E260481
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 22:30:55 +0100 (CET)
In-Reply-To: <s5h4mqb6o2x.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

According to this (http://www.alsa-project.org/main/index.php/Matrix:Vendor-Creative_Labs) it specifically states "X-Fi Xtreme Audio (PCIe) CA0110 [PCIE] does not work". Is this list up to date?



----- Original Message -----
From: Takashi Iwai <tiwai@suse.de>
To: Alnie <alnieb@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Tuesday, February 24, 2015 12:39 PM
Subject: Re: [alsa-devel] Issues w/ Creative Labs [SB X-Fi	Xtreme	Audio]	CA0110-IBG

At Tue, 24 Feb 2015 20:10:00 +0000 (UTC),
Alnie wrote:
> 
> Yes, it has been working for me in Windows 7.

Then I have no idea what's wrong.  You'd need to try contact with
Creative Labs people...


Takashi

> 
> 
> ----- Original Message -----
> From: Takashi Iwai <tiwai@suse.de>
> To: Alnie <alnieb@yahoo.com>
> Cc: alsa-devel@alsa-project.org
> Sent: Tuesday, February 24, 2015 11:52 AM
> Subject: Re: [alsa-devel] Issues w/ Creative Labs [SB X-Fi Xtreme    Audio]    CA0110-IBG
> 
> At Tue, 24 Feb 2015 18:14:44 +0000 (UTC),
> Alnie wrote:
> > 
> > 
> > 
> > I've included the following to alsa-base.conf
> > 
> > options snd-hda-intel single_cmd=1
> > options snd-hda-intel enable_msi=0
> > 
> > rebooted and get the following messages back...
> > 
> > [    4.015887] hda-intel 0000:06:00.0: Using LPIB position fix
> > [    4.022650] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
> > [    4.022655] hda-intel 0000:06:00.0: Codec #1 probe error; disabling it...
> > [    4.029465] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
> > [    4.029649] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
> > [    4.029829] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
> > [    4.030009] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
> > [    4.030188] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
> > [    4.030192] hda-intel 0000:06:00.0: no codecs initialized
> 
> If the single command mode doesn't work, it's probably a deeper
> problem than the sound driver.
> 
> Does the device work with other OS at all?
> 
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
