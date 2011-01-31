From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to
 determine jack type
Date: Mon, 31 Jan 2011 12:06:05 +0000
Message-ID: <1296475565.3316.48.camel@odin>
References: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 29DE5244E4
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 13:06:09 +0100 (CET)
Received: by wyi11 with SMTP id 11so5367401wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 04:06:09 -0800 (PST)
In-Reply-To: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Vinod@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-28 at 22:39 +0530, Harsha Priya wrote:
> This patch adds a helper function that determines the jack type
> given the mic bias value. For any codec that would give
> the mic bias value on a jack insertion, this function would
> return the type of jack based on mic bias range
> 
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
