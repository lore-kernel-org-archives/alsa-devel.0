From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/2] keywest: Convert to new-style i2c
	driver
Date: Tue, 14 Apr 2009 16:37:01 +0200
Message-ID: <20090414163701.0609a189@hyperion.delvare>
References: <20090410170726.3616b6d5@hyperion.delvare>
	<20090410170951.084e9b5c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DC3C103861
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 16:37:08 +0200 (CEST)
In-Reply-To: <20090410170951.084e9b5c@hyperion.delvare>
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
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Apr 2009 17:09:51 +0200, Jean Delvare wrote:
> Ah, I forgot. You need the following patch applied before testing:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-loosen-driver-check.patch

This patch is is Linus' tree now:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=935298696f469c0e07c73be687bd055878074ce0

-- 
Jean Delvare
