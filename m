From: Timur Tabi <timur@freescale.com>
Subject: Re: params_buffer_size() and params_period_bytes() are
 returning the same value
Date: Wed, 14 Nov 2007 15:57:14 -0600
Message-ID: <473B6F3A.1010100@freescale.com>
References: <473B6E5D.3040303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 023C024822
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 22:57:17 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lAELvFYA002236
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 14:57:15 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAELvENe029862
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 15:57:14 -0600 (CST)
In-Reply-To: <473B6E5D.3040303@freescale.com>
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

Timur Tabi wrote:

> Why am I getting the same value for buffer_size and period_size?  buffer_size 
> should be four times period_size.

Never mind.  buffer_size is the size in frames, not bytes, and each frame is 4 
bytes.  Duh.


-- 
Timur Tabi
Linux kernel developer at Freescale
