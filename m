From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to update hw_ptr and appl_ptr
Date: Tue, 26 Jun 2012 11:34:49 +0200
Message-ID: <4FE98239.7050908@ladisch.de>
References: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 022A1245BD
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 11:35:25 +0200 (CEST)
In-Reply-To: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Zhen Fu wrote:
> I recently look the function snd_pcm_update_hw_ptr0 want to  find how
> to update status->hw_ptr and control->appl_ptr.

status->hw_ptr is updated by snd_pcm_update_hw_ptr0.  control->appl_ptr
is updated by snd_pcm_lib_write1.

Why are you asking?


Regards,
Clemens
