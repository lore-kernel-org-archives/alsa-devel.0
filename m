From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Module unloading fix
Date: Thu, 04 Feb 2010 10:14:15 +0000
Message-ID: <1265278455.3198.10.camel@odin>
References: <1265267410-8007-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A6F224362
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 11:14:20 +0100 (CET)
Received: by ewy23 with SMTP id 23so125847ewy.4
	for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2010 02:14:19 -0800 (PST)
In-Reply-To: <1265267410-8007-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-02-04 at 09:10 +0200, Peter Ujfalusi wrote:
> The module unloading path had several problems:
> - it freed up the private structure twice
> - it freed up the codec structure, which was allocated as part
>   of the private structure
> - it did not freed up the reg_cache
> - it did not unregistered the dais and the codec
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
