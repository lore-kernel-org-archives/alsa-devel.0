From: Amit Nagal <helloin.amit@gmail.com>
Subject: regarding setting of fragment size in usbaudio driver
Date: Sat, 11 Dec 2010 18:16:30 +0900
Message-ID: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0068724333
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 10:16:31 +0100 (CET)
Received: by vws20 with SMTP id 20so2694752vws.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 01:16:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, helloin.amit@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi ,

i am using a OSS based usbaudio application for usb audio streaming .

my usb audio device is capture only device .

i want to set the fragment size of usbaudio alsa driver to reduce
latency problem coming in my application .

currently even if my application reads 4k data from userspace , i
observed driver will buffer for 100 ms data ( period size data )= 16 k
at 44100 frquency

and after driver  reads 16k data , read call will return with 4k data
.  so read() call remains blocked for 100ms which is causing some
latency problem .

i used SNDCTL_DSP_SETFRAGMENT  ioctl , but still driver behaviour to
buffer 100ms data remained same .

how driver's  fragment size in driver can be set to some less value in
OSS based application .

Can some patch  be implemented in kernel space to do that .?


Thanx & Regards
Amit Nagal
