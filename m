From: Robert Gonciarz <ruppertus@gmail.com>
Subject: Re: snd-hda-intel AD1981 - the microphone doesn't work
Date: Wed, 13 Feb 2008 22:44:50 +0100
Message-ID: <47B364D2.3020400@gmail.com>
References: <47B1D340.4070907@gmail.com>	<200802122102.07320.grzegorz.chwesewicz@chilan.com>
	<s5hfxvwsvyi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 38C962456B
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2008 22:46:15 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so1160144uge.50
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2008 13:46:14 -0800 (PST)
In-Reply-To: <s5hfxvwsvyi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, chilek@chilan.com, Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
List-Id: alsa-devel@alsa-project.org

I've tried to compile 1.0.16 version.
That's the result of the script:
http://pastebin.ca/902946

R.

Takashi Iwai wrote:

> Now it's interesting whether Robert's machine also gets a similar
> hang-up with recording.  I guessed it's specific to AMD chipset, but
> if the same problem (I mean here about the hang up, not the silent 
> capture) occurs on Intel chipset, then the problem must be somewhere
> in the driver code in general.
> 
> Robert, please check whether this hang-up problem occurs on yours?
> 
> 
> Takashi
> 
