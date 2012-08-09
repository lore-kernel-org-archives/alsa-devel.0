From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: ad1836: convert to use
 snd_soc_register_card
Date: Thu, 9 Aug 2012 14:08:41 +0100
Message-ID: <20120809130841.GS24328@opensource.wolfsonmicro.com>
References: <1344550120-30901-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF3292652BF
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 14:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344550120-30901-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 09, 2012 at 06:08:39PM -0400, Scott Jiang wrote:
> Cpu dai and codec name are passed in through platform data.

Won't applying this break all existing boards - there's no patch adding
platform data here?  We should merge the updates for the boards together
with the driver update to ensure they still work, or provide default
platform data so that only boards that wish to change something from the
current code need to be updated.

Also, the patch description should be something like "ASoC: bf5xx-ad1836"
as it's a board driver change.
