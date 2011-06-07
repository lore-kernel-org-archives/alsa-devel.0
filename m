From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] UCM: get: Implement 'exact' value retrieval
Date: Tue, 7 Jun 2011 09:32:16 +0100
Message-ID: <4DEDE210.3020509@ti.com>
References: <1307391417-3199-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B274C24390
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:32:20 +0200 (CEST)
In-Reply-To: <1307391417-3199-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 21:16, Stephen Warren wrote:
> [=]<NAME>[/[<modifier>|</device>][/<verb>]]
> - value identifier <NAME>
> - Search starts at given modifier or device if any,
>     else at a verb
> - Search starts at given verb if any,
>     else current verb
> - Searches modifier/device, then verb, then defaults
> - Specify a leading "=" to search only the exact
>   device/modifier/verb specified, and not search
>   through each object in turn.
> - Examples:
>     "PlaybackPCM/Play Music"
>     "CapturePCM/SPDIF"
>   From ValueDefaults only:
>     "=Variable"
>   From current active verb:
>     "=Variable//"
>   From verb "Verb":
>     "=Variable//Verb"
>   From "Modifier" in current active verb:
>     "=Variable/Modifier/"
>   From "Modifier" in "Verb":
>     "=Variable/Modifier/Verb"
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>
Acked-by: Liam Girdwood <lrg@ti.com>
