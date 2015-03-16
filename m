From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8741: Fix rates constraints values
Date: Mon, 16 Mar 2015 14:57:39 +0000
Message-ID: <20150316145739.GJ17136@opensource.wolfsonmicro.com>
References: <1426281614-12147-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 341552610B1
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 15:57:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1426281614-12147-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 13, 2015 at 10:20:14PM +0100, Sergej Sawazki wrote:
> According to table 11 in the datasheet (Rev 4.3):
> Example: With a master clock (MCLK) of 11.2896MHz, the following sampling rates (LRCLK) are supported:
>   44.1kHz (MCLK/256), 88.2kHz (MCLK/128)
> 
> For the rates lists, we should use 82000 instead of 88235 and 176400 instead of 1764000 (seems to be a typo).
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
