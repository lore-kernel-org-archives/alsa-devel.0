From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix output PGA enabling in wm_hubs
 CODECs
Date: Mon, 11 Apr 2011 20:52:51 +0100
Message-ID: <1302551571.3449.57.camel@odin>
References: <1302249947-1414-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A5F2A10384C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:52:55 +0200 (CEST)
Received: by wyg36 with SMTP id 36so5573265wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:52:55 -0700 (PDT)
In-Reply-To: <1302249947-1414-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-04-08 at 17:05 +0900, Mark Brown wrote:
> The output PGA was not being powered up in headphone and speaker paths,
> removing the ability to offer volume control and mute with the output
> PGA.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm_hubs.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>
