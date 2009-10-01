From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: adding hrtimer based delay to ioplug ALSA plugin on
 ARM9 (AT91) platform ?
Date: Thu, 01 Oct 2009 14:32:58 +0200
Message-ID: <4AC4A17A.4040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 60C8D103934
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:32:59 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 196454BE06
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:33:53 +0200 (CEST)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ANq-uWP1qiNi for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:33:52 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id AC4E44BE02
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:33:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm currently developing an ALSA ioplug plugin which should transfer
audio samples over UART to a DSP (I already wrote that in a previous post).

The DSP wants to receive 156 - 164 audio samples with a sampling rate of
8 kHz and a format of S16_LE each 20 msec (which is more or less the
number of audio samples multiplied by the period length of the sampling
rate).

My idea is to add a high precision delay to the transfer callback of the
ALSA plugin.

Unfortunately, I found out that the hrtimer resolution on the system is
as low as 10ms:

-------------------------------------------------------------------
kernel: hrtimer resolution: 0 sec, 10000000 nsec, loops_per_jiffy: 448512
-------------------------------------------------------------------


* Does this mean that if I use nanosleep for example each delay has to
be an integral multiple of the hrtimer precision and for example a delay
of 15ms would not be supported (since it is no integral multiple of 10ms) ?


* It is possible to increase the precision (e.g. by changing the kernel
configuration) ?


* Do you know a better solution for the task, where the task is to send
and receive audio samples to/from the DSP over UART and the timing is
critical ?


cheers,
Stefan
