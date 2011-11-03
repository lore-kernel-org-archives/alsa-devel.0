From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Thu, 03 Nov 2011 16:21:42 +0100
Message-ID: <4EB2B186.60405@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-2-git-send-email-zonque@gmail.com>
	<4EB11ADD.2090701@ladisch.de> <4EB153BF.2090204@gmail.com>
	<4EB1669E.5040701@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BB8B2243A3
	for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2011 16:21:52 +0100 (CET)
Received: by eyz10 with SMTP id 10so1215311eyz.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Nov 2011 08:21:52 -0700 (PDT)
In-Reply-To: <4EB1669E.5040701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 11/02/2011 04:49 PM, Clemens Ladisch wrote:
> Example with queue length = 2:
>
> 1) startup:
>     driver queues both capture URBs
> 2) 1st capture URB completes:
>     driver queues 1st playback URB and requeues 1st capture URB
> 3) 2nd capture URB completes:
>     driver queues 2nd playback URB and requeues 2nd capture URB
>     (all URBs are now queued)
> 4) 1st capture URB completes:
>     1st playback URB is still busy
>     (The playback URB might have been scheduled for a later frame, and
>     even for the same frame, there is no guarantee that the completions
>     for different endpoints happen in the same order as the queueing.)

I see. However, this really never happened in my tests so far. What 
would be a way to fix this? Queue less capture urbs than available slots 
for playback urbs?


Daniel
