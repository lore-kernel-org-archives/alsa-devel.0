From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - Separate out PCM operations
	into new file.
Date: Thu, 9 Jun 2011 11:34:14 +0100
Message-ID: <4DF0A1A6.7020303@ti.com>
References: <1307615279-3005-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A9CD11037F5
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 12:34:21 +0200 (CEST)
In-Reply-To: <1307615279-3005-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09/06/11 11:27, Girdwood, Liam wrote:
> In preparation for Dynamic PCM support (AKA DSP support).
> 
> There will be future patches that add support to allow PCMs to be dynamically
> routed to multiple DAIs at startup and also during stream runtime. This patch
> moves the ASoC core PCM operaitions into a new file called soc-pcm.c.  This will
> in simplify the ASoC core features into distinct files.
> 
> Signed-off-by: Liam Girdwood <lrg@ti.com>
> ---
>  sound/soc/Makefile   |    2 +-
>  sound/soc/soc-core.c |  612 +-----------------------------------------------
>  sound/soc/soc-pcm.c  |  645 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 647 insertions(+), 612 deletions(-)
>  create mode 100644 sound/soc/soc-pcm.c
> 

gah, forgot to strip out unused headers. V2 after lunch.

Liam
 
