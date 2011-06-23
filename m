From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ALSA: ASoC: pxa-ssp: Correct check for
	stream presence
Date: Thu, 23 Jun 2011 13:18:14 +0100
Message-ID: <4E032F06.6010406@ti.com>
References: <1308768505-19878-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 584A5103849
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 14:18:17 +0200 (CEST)
In-Reply-To: <1308768505-19878-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 22/06/11 19:48, Daniel Mack wrote:
> Don't rely on the codec's channels_min information to decide wheter or
> not allocate a substream's DMA buffer. Rather check if the substream
> itself was allocated previously.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
