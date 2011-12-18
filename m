From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] RFC v2 for snd-usb endpoint
	logic	rework
Date: Sun, 18 Dec 2011 23:57:53 +0100
Message-ID: <4EEE6FF1.90601@gmail.com>
References: <1321646744-13656-1-git-send-email-zonque@gmail.com>
	<4ED25CE2.4010706@gmail.com> <4ED29E6F.3010806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BFF42103819
	for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2011 23:58:00 +0100 (CET)
Received: by eekb57 with SMTP id b57so4645549eek.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2011 14:58:00 -0800 (PST)
In-Reply-To: <4ED29E6F.3010806@ladisch.de>
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

On 11/27/2011 09:32 PM, Clemens Ladisch wrote:
> Daniel Mack wrote:
>> Did anyone find some time to test this, also with 'regular' USB devices?
> 
> With an Edirol UA-1A (stereo, 16 bits, 44.1 kHz, adaptive), the first
> attempt to start playback fails (no sound), but the program can be
> exited:

[...]

Thanks for the feedback!

I'm confident I found these hickups, and I'm about to resend a new
version in a few minutes. I'd appreciate if you could repeat your tests
with your hardware :)


Daniel
