From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: reset of kernel input buffer for /dev/dsp
Date: Mon, 29 Nov 2010 09:00:27 +0100
Message-ID: <4CF35D9B.40202@ladisch.de>
References: <AANLkTi=EzbQc__Z+4JCrMNbGpWoKWKmyX+BFhuLcKt7T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0B13210384E
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 08:58:23 +0100 (CET)
In-Reply-To: <AANLkTi=EzbQc__Z+4JCrMNbGpWoKWKmyX+BFhuLcKt7T@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: alsa-user@lists.sourceforge.net, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Amit Nagal wrote:
> we want to flush  kernel input pcm buffer  without using close() system call .
> 
> does OSS supports in userspace any ioctl call which can flush kernel
> pcm buffer at any time .

SNDCTL_DSP_RESET


Regards,
Clemens
