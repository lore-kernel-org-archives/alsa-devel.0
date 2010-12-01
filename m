From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Correct event flags for WM8958
 AIF DACs
Date: Wed, 01 Dec 2010 09:51:11 +0000
Message-ID: <1291197071.3292.3.camel@odin>
References: <1291136796-8525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 002291039CE
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:51:14 +0100 (CET)
Received: by wyi11 with SMTP id 11so6736189wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 01:51:14 -0800 (PST)
In-Reply-To: <1291136796-8525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-30 at 17:06 +0000, Mark Brown wrote:
> We need a post notification as we need to shut down the MBC after the
> data stops flowing rather than before.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
