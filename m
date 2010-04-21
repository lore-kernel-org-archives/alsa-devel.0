From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-python: add register_poll to alsaseq
Date: Wed, 21 Apr 2010 08:52:44 +0200
Message-ID: <4BCEA0BC.3060905@ladisch.de>
References: <4BCE7868.1020108@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 0AC981037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 08:52:47 +0200 (CEST)
In-Reply-To: <4BCE7868.1020108@marcansoft.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hector Martin <hector@marcansoft.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hector Martin wrote:
> Attached patch adds register_poll to the sequencer bindings to support
> nonblocking sequencer access with the select module.
> 
> From db1a07ad9e9076f258d1ff871955eedc7d34ae9c Mon Sep 17 00:00:00 2001
> From: Hector Martin <hector@marcansoft.com>
> Date: Wed, 21 Apr 2010 05:54:49 +0200
> Subject: [PATCH] Add register_poll for alsaseq
> 
> ---
>  pyalsa/alsaseq.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 53 insertions(+), 0 deletions(-)

Please provide a Signed-off-by tag; we use this also for non-kernel code.

> +    pfd = malloc(sizeof(struct pollfd) * count);

This isn't freed; better use alloca().


Regards,
Clemens
