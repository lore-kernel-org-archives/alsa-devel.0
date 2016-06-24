From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: wm8753: Remove unneeded header file
Date: Fri, 24 Jun 2016 09:05:58 +0100
Message-ID: <20160624080558.GW1552@localhost.localdomain>
References: <20160624062135.GA23457@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B67261A06
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2016 10:05:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160624062135.GA23457@amitoj-Inspiron-3542>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, julia.lawall@lip6.fr, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2016 at 11:51:36AM +0530, Amitoj Kaur Chawla wrote:
> Drop redundant include of moduleparam.h
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @ includesmodule @
> @@
> 
> #include <linux/module.h>
> 
> @ depends on includesmodule @
> @@
> 
> - #include <linux/moduleparam.h>
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
