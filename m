From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hw_ptr_interrupt removal broke interrupt pointer
 updates
Date: Wed, 27 Jan 2010 10:49:50 +0100
Message-ID: <4B600C3E.6090208@ladisch.de>
References: <4B5EF09B.3040900@ladisch.de>
	<alpine.LNX.2.00.1001261713430.6542@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4B0E82415F
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 10:49:53 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1001261713430.6542@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> I returned hw_ptr_interrupt variable back. I am testing this patch now:
> 
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=04d64a69fcb9fd182d73d6f1a8de55b2f527a1de
> 
> A review is always welcome. Thanks.

The patch looks fine, and it works again now.


A somewhat unrelated issue:  Both old and new code assume that
hw_ptr==0 is a period boundary, but that is not true if the boundary
is not an integer multiple of the period size, and the pointer wraps.
I'm not sure what happens then.


Best regards,
Clemens
