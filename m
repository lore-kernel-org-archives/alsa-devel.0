From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] *** ASoC: core: refine of node id parse of
 cpu/codec dai ***
Date: Wed, 18 Jun 2014 14:13:39 +0200
Message-ID: <53A18273.7090203@metafoo.de>
References: <1403089319-2555-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-215.synserver.de (smtp-out-215.synserver.de
 [212.40.185.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 2009E261A74
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 14:13:47 +0200 (CEST)
In-Reply-To: <1403089319-2555-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, zhangfei.gao@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/18/2014 01:01 PM, Qiao Zhou wrote:
> Hi Mark, Liam
>
> This patch is to add another check besides cpu_dai/codec_dai name during
> dai_link bind. currently if the cpu_dai/codec_dai name match corresponding
> dai_link cpu/codec name, then a match is found. in this patch, it also checks
> whether cpu/codec dai id match dailink cpu_dai_id/codec_dai_id. Still check
> name first.
> 1. if it doesn't match, it will keep checking whether cpu_id/codec_id match
> corresponding dai_link cpu_dai_id/codec_dai_id. if the ids are equal, then
> a match is found.
> 2. if it does match, then a match is already found. no need to further check.
>
[...]
> Could you help share your opinions? Thanks in advance.

Hi,

There is already snd_soc_of_get_dai_name() which will translate a phandle + 
specifier to a DAI name. By default it will use the DAI id for the 
specifier. Alternatively the driver can implement a of_xlate_dai_name 
callback that does the translation from specifier to name. The advantage of 
this approach is that the board driver does not need to know about the 
specific format of the DAI specifier.

- Lars
