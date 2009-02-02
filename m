From: Tim Barnette <tim.barnette@gmail.com>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Mon, 2 Feb 2009 11:26:25 -0500
Message-ID: <b71cdde20902020826g45f8d088n123332e98edfefcb@mail.gmail.com>
References: <4983FE7A.1040201@wanadoo.fr> <49840333.2080303@wanadoo.fr>
	<b71cdde20902011434x690860d7jf9e1fc762ff2d3a9@mail.gmail.com>
	<s5h1vuh9w16.wl%tiwai@suse.de>
	<b71cdde20902020717qf508d38n742ef396171abce4@mail.gmail.com>
	<s5hzlh4dfnk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D9B710381B
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 17:26:26 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so772747wah.16
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2009 08:26:25 -0800 (PST)
In-Reply-To: <s5hzlh4dfnk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Jean=2DPierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

Thanks, Takashi.  I tried installing the latest snapshot but wound up
recompiling a bunch of stuff (which my box is not configured for)... Is
there an easy way to download and install the latest snapshot?

Is there a way to fix the 0x0d widget?  BIOS flash?  laptop seems kind of
new for that...

On Mon, Feb 2, 2009 at 10:25 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 2 Feb 2009 10:17:03 -0500,
> Tim Barnette wrote:
> >
> > Thanks, Takashi. I made this change and rebooted.
> >
> > I noticed right away the mute light is no longer on... but still no sound
> > through speakers, only headphones..
> >
> > /sys/module/snd_hda_intel/parameters/model
> > contains
> > hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
> >
> > attached is the alsa-info.txt you requested..
>
> Did you try the latest alsa-driver snapshot?
>
> If it still doesn't work, I guess this is a BIOS problem.
> The other HP dv laptops show the widget 0x0d as the speaker while
> yours is unused.
>
> Try to run:
>        hda-verb /dev/snd/hwC0D0 0x0d SET_PIN_WID 0x40
>
>
> Takashi
>
