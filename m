From: Sriram Periyasamy <sriram.oqensourz@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Sat, 31 Mar 2018 12:13:34 +0530
Message-ID: <20180331064332.wb4ay4vfzkguj7jy@sriram-VirtualBox>
References: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
 <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id BC7852671B9
 for <alsa-devel@alsa-project.org>; Sat, 31 Mar 2018 08:43:48 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id j2so6689937pff.10
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 23:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, broonie@kernel.org, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 30, 2018 at 03:34:57PM +0530, Akshu Agrawal wrote:
> This enables/disables and sets auxiliary clock at 25Mhz. It uses
> common clock framework for proper ref counting. This approach will
> save power in comparison to keeping it always On in firmware.
> 
> TEST= aplay -vv <file>
> check register to see clock enabled
> kill aplay
> check register to see clock disabled
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> V2: Correcting the pin to OSCOUT1 from OSCOUT2
> V3: Fix error/warnings from kbuild test
> V4: Fix build errors for platform which do not support CONFIG_COMMON_CLK
> V5: Review comments by Dan and Sriram
> 

LGTM.

Thanks,
Sriram.

>  sound/soc/amd/acp-da7219-max98357a.c | 159 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 157 insertions(+), 2 deletions(-)
