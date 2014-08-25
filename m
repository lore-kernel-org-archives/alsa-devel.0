From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename
	big_endian_data to is_msb_first.
Date: Sun, 24 Aug 2014 22:18:37 -0500
Message-ID: <53FAAB0D.2000403@tabi.org>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BC58261AF7
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 05:18:30 +0200 (CEST)
In-Reply-To: <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>, broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, nicoleotsuka@gmail.com
Cc: devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Xiubo Li wrote:
> -	sai->big_endian_data = of_property_read_bool(np, "big-endian-data");
> +	sai->is_msb_first = of_property_read_bool(np, "msb-first");

This will break backwards compatibility with older device trees.
