From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix WM9713 mic 2 preamp volume
Date: Sat, 17 May 2014 15:52:45 +0100
Message-ID: <20140517145245.GO25203@opensource.wolfsonmicro.com>
References: <1400183425-23628-1-git-send-email-mreimer@sdgsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DF32261987
 for <Alsa-devel@alsa-project.org>; Sat, 17 May 2014 16:52:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1400183425-23628-1-git-send-email-mreimer@sdgsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Reimer <mreimer@sdgsystems.com>, broonie@kernel.org
Cc: Alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 15, 2014 at 12:50:25PM -0700, Matt Reimer wrote:
> Fix WM9713's mic 2 preamp volume. The previous definition specified
> the Mic A pre-amp input select bits (aka "Mic A Source") instead.
> 
> Signed-off-by: Matt Reimer <mreimer@sdgsystems.com>
> ---

Change looks good, but remember to CC the maintainers on patches.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
