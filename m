From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: HDA driver without interrupt
Date: Thu, 03 May 2012 10:37:52 +0200
Message-ID: <4FA243E0.10506@ladisch.de>
References: <4FA12E91.8050804@gmail.com> <4FA22223.2000307@ladisch.de>
	<CAOAAS1z7iA2excEt9cE45CBmQs=XUkigW6+A94zyp2BuRLBBcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 5E61B10403D
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 10:33:45 +0200 (CEST)
In-Reply-To: <CAOAAS1z7iA2excEt9cE45CBmQs=XUkigW6+A94zyp2BuRLBBcA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fanchao Liu <liufc10@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fanchao Liu wrote:
> It can transfer data via DMA,the problem is I don't know when to
> update hw_ptr and other pointers without interrupt.

Does the hardware have some other means to at least read the current
position?

> I set a timer and call snd_pcm_period_elapsed() every 50ms but get
> underrun error.

With a call to snd_pcm_period_elapsed(), the driver guarantees that the
current position is at or after the next period boundary.


Regards,
Clemens
