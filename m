From: Matt Bucknall <matt@mattbucknall.com>
Subject: Lock free ring buffers and SMP safety
Date: Sun, 18 Nov 2007 17:31:52 +0000
Message-ID: <47407708.2080902@mattbucknall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from weshsrv039.weshsrv039.co.uk (weshsrv039.weshsrv039.co.uk
	[83.223.101.110])
	by alsa0.perex.cz (Postfix) with ESMTP id 82E952473D
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 18:31:51 +0100 (CET)
Received: from cpc3-bror4-0-0-cust854.bmly.cable.ntl.com ([86.11.83.87]
	helo=[192.168.40.2])
	by weshsrv039.weshsrv039.co.uk with esmtpa (Exim 4.63)
	(envelope-from <matt@mattbucknall.com>) id 1Itnzs-0007cY-JC
	for alsa-devel@alsa-project.org; Sun, 18 Nov 2007 17:31:52 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Yes, this old chestnut. I've spent the best part of today trying to 
ascertain whether or not, in practical terms, a single-producer, 
single-consumer lock free ring-buffer can be written purely in C/C++ and 
be SMP safe on multiple architectures without memory barriers. 
Information I've found has been largely conflicting so I've given up 
trying to get a conclusive answer. Instead I'll just go with the flow.

What is the general consensus amongst ALSA application developers when 
it comes to implementing this kind of buffer? Is it possible to use 
memory barriers through some user space API call that I don't know about?

Thanks in advance for any comments/suggestions.
Matt.
