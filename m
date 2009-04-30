From: Gabriel Johnson <johnsoga@gmail.com>
Subject: Re: dmix and mmap
Date: Thu, 30 Apr 2009 14:29:41 -0500
Message-ID: <bb6204720904301229q3b0b93eao28563ec7bdef73cb@mail.gmail.com>
References: <bb6204720904300810ma174b6cn825f8565c0b694c0@mail.gmail.com>
	<20090430151301.GA27605@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id ABA14246B7
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 21:29:42 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so1241982ana.2
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2009 12:29:41 -0700 (PDT)
In-Reply-To: <20090430151301.GA27605@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I updated to 1.0.19, it appears that aplay -Dplug:dmix -f cdr raw.wave
is working.  Now using the ioctl to get mmap address of the dma space
isn't working, I get a kernel machine check error:

Playing raw data '/home/bin/stw.raw' : Signed 16 bit Big Endian, Rate
44100 Hz, Stereo
[   78.475303] Machine check in kernel mode.
[   78.479246] Caused by (from SRR1=ff37598): Unknown values in msr
[   78.527195] Machine check in kernel mode.
[   78.531121] Caused by (from SRR1=47590): Transfer error ack signal
[   78.540376] Bad page state in process 'aplay'
[   78.540388] page:c5be3f20 flags:0x00000004 mapping:00000000
mapcount:1 count:0
[   78.540400] Trying to fix it up, but a reboot is needed

Should the default mmap ioctl functions work on powerpc?

Thanks,
Gabe

On Thu, Apr 30, 2009 at 10:13 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Apr 30, 2009 at 10:10:23AM -0500, Gabriel Johnson wrote:
>
>> I am using alsa-lib-1.0.11rc2.
>
> This is a very old version of alsa-lib - I haven't looked at either of
> your problems but I would suggest upgrading to a current version (the
> release version is 1.0.19).
>
