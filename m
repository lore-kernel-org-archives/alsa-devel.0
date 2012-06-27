From: Zhen Fu <fuzh@marvell.com>
Subject: Re: how to update hw_ptr and appl_ptr
Date: Tue, 26 Jun 2012 20:13:31 -0700
Message-ID: <DBBC59900F0EF340B9938F193FB1A3453611F4F2@SC-VEXCH4.marvell.com>
References: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
	<4FE98239.7050908@ladisch.de>
	<DBBC59900F0EF340B9938F193FB1A3453605DD79@SC-VEXCH4.marvell.com>
	<4FE9AA98.7000307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog129.obsmtp.com (na3sys009aog129.obsmtp.com
	[74.125.149.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 8949B24455
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 05:13:43 +0200 (CEST)
In-Reply-To: <4FE9AA98.7000307@ladisch.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zhen Fu <fuzh@marvell.com>
List-Id: alsa-devel@alsa-project.org

Because when I use aplay playback wav file, appear underrun phenomenon. So I want to ALSA driver how to handle xrun.

--
Best Regards,
Zhen Fu

-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Tuesday, June 26, 2012 8:27 PM
To: Zhen Fu
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] how to update hw_ptr and appl_ptr

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
