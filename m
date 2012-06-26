From: Zhen Fu <fuzh@marvell.com>
Subject: Re: how to update hw_ptr and appl_ptr
Date: Tue, 26 Jun 2012 02:37:54 -0700
Message-ID: <DBBC59900F0EF340B9938F193FB1A3453605DD72@SC-VEXCH4.marvell.com>
References: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
	<4FE98239.7050908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog135.obsmtp.com (na3sys009aog135.obsmtp.com
	[74.125.149.84]) by alsa0.perex.cz (Postfix) with ESMTP id E26EE245C6
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 11:38:31 +0200 (CEST)
In-Reply-To: <4FE98239.7050908@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Yes, I know this. I want to know how about updated by snd_pcm_update_hw_ptr0.

--
Best Regards,
Zhen Fu

-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Tuesday, June 26, 2012 5:35 PM
To: Zhen Fu
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] how to update hw_ptr and appl_ptr

Zhen Fu wrote:
> I recently look the function snd_pcm_update_hw_ptr0 want to  find how
> to update status->hw_ptr and control->appl_ptr.

status->hw_ptr is updated by snd_pcm_update_hw_ptr0.  control->appl_ptr
is updated by snd_pcm_lib_write1.

Why are you asking?


Regards,
Clemens
