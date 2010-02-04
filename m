From: "Rene E. Henriquez G." <rene.henriquez@gmail.com>
Subject: Re: ioctl problem - help please!!
Date: Thu, 4 Feb 2010 14:31:08 -0600
Message-ID: <60ef6ece1002041231yf139642yd5c13b0005ce2ad2@mail.gmail.com>
References: <60ef6ece1002021334q4eb53641p5308f84847ed3949@mail.gmail.com>
	<4B6A9722.3070109@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f223.google.com (mail-fx0-f223.google.com
	[209.85.220.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 8372E10382F
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 21:31:09 +0100 (CET)
Received: by fxm23 with SMTP id 23so53278fxm.22
	for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2010 12:31:08 -0800 (PST)
In-Reply-To: <4B6A9722.3070109@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks a lot for your reply Clemens.

The driver is Type

On Thu, Feb 4, 2010 at 3:45 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rene E. Henriquez G. wrote:
> > Does anybody know what might cause this:
> >
> > 2925  open("/dev/snd/pcmC0D0c", O_RDWR|O_NONBLOCK) = 5
> > 2925  ioctl(5, 0x80184151, 0x7ffff3351890) = -1 EIO (Input/output error)
> >
> > to give EIO?
>
> Some error detected by the driver.  Which driver?
> Does normal recording work?
>
>
> Regards,
> Clemens
>
