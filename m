From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Fix SOC_DOUBLE_R_SX_TLV volume mixer
	arguments
Date: Fri, 20 Jun 2014 15:03:58 -0500
Message-ID: <alpine.DEB.2.02.1406201503070.25941@heelrod>
References: <1403294418-6743-1-git-send-email-ryan.harvey@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A472610A7
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 22:01:39 +0200 (CEST)
In-Reply-To: <1403294418-6743-1-git-send-email-ryan.harvey@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Harvey <ryan.harvey@cirrus.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Jun 2014, Ryan Harvey wrote:

> Remove unnecessary bit shifts. Correct min value to match datasheet. #Steps equals number of steps between min and max.
>
> This patch depends on 8f0367b53d887726b1f4b0b39e0f09b7cca2f79f
> ASoC: cs42l56: Fix stereo channel register assignment for Headphone and
> LineOut volume mixers.
>
> Signed-off-by: Ryan Harvey <ryan.harvey@cirrus.com>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks,
