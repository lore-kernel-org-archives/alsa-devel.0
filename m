From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to update hw_ptr and appl_ptr
Date: Tue, 26 Jun 2012 14:27:04 +0200
Message-ID: <4FE9AA98.7000307@ladisch.de>
References: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
	<4FE98239.7050908@ladisch.de>
	<DBBC59900F0EF340B9938F193FB1A3453605DD79@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 438C92466D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 14:27:40 +0200 (CEST)
In-Reply-To: <DBBC59900F0EF340B9938F193FB1A3453605DD79@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zhen Fu <fuzh@marvell.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Zhen Fu wrote:
> when DMA handler called snd_pcm_period_elapsed, so I want to know how
> about update hw_ptr in ALSA.

snd_pcm_period_elapsed() calls snd_pcm_update_hw_ptr0(), which calls
your driver's .pointer callback.  The value returned by that callback
essentially is the hw_ptr (although it doesn't wrap around at the end
of the buffer).

Why do you care about hw_ptr?


Regards,
Clemens
