From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FastTrack C400
Date: Fri, 20 Apr 2012 09:54:17 +0200
Message-ID: <4F911629.5090704@gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA8B6103F40
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 10:10:45 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so7577220bkw.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2012 01:10:45 -0700 (PDT)
In-Reply-To: <4F8FD2A7.60700@ladisch.de>
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
Cc: Grant Diffey <gdiffey@gmail.com>, chris-alsa@rauros.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/19/2012 10:53 AM, Clemens Ladisch wrote:
> Chris Cavey wrote:
>>  snd-usb-audio: probe of 1-1:1.1 failed with error -5
>>  snd-usb-audio: probe of 1-1:1.2 failed with error -5
>>  snd-usb-audio: probe of 1-1:1.3 failed with error -5
> 
> Are there no other messages immediately before this?
> 
> Daniel, are there places where the code aborts without
> print an error message?

Yes, there are in fact some. -5 means -EIO, and the module probe will
fail with this error code in case snd_usb_audio_probe() returns NULL.
Chris, can you trace this functions in sound/usb/card.c and see where it
bails?



Daniel
