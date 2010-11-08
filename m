From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: Use BUG_ON() for
 unsupported hw_read() calls
Date: Mon, 08 Nov 2010 15:42:53 +0000
Message-ID: <1289230973.3288.159.camel@odin>
References: <1289230627-15353-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6FABF243FB
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 16:42:57 +0100 (CET)
Received: by wyb33 with SMTP id 33so3690132wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2010 07:42:57 -0800 (PST)
In-Reply-To: <1289230627-15353-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-11-08 at 15:37 +0000, Dimitris Papastamos wrote:
> Instead of dereferencing a NULL function pointer and falling apart
> use BUG_ON() for any unimplemented hw_read() calls.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
