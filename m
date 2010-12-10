From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: Custom IOCTL call
Date: Sat, 11 Dec 2010 12:23:40 +1300
Message-ID: <4D02B67C.10903@audioscience.com>
References: <AANLkTinRmEkLL8Lhp9uZVCWjn2Z3Qh0cgwKZGqJG8o0p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EB7C10380C
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 00:23:47 +0100 (CET)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LD800FPNJNJ4I10@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 11 Dec 2010 12:23:43 +1300 (NZDT)
In-reply-to: <AANLkTinRmEkLL8Lhp9uZVCWjn2Z3Qh0cgwKZGqJG8o0p@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/12/10 08:42, Radivoje Jovanovic wrote:
> I am writing custom IOCTL calls for my card. I have made hwdep interface and
> set ioctl ops call for it. But, now the question is which device I need to
> open in my user space app to talk to correct ioctl?

/dev/snd/hwC0D0

> I have tried /dev/snd/controlC0
> and /dev/snd/pcmC0D0p
