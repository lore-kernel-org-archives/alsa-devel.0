From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 5/6] ASoC: uniperf: Staticise local symbols
Date: Tue, 28 Jul 2015 09:49:20 +0200
Message-ID: <55B73400.2030905@st.com>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
 <1437987388-9706-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 31B572604C5
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 09:49:25 +0200 (CEST)
In-Reply-To: <1437987388-9706-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Max Filippov <jcmvbkbc@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 07/27/2015 10:56 AM, Lars-Peter Clausen wrote:
> uni_player_dai_ops is not used outside of this file so it should be static.
> Fixes the following sparse warning:
>
> 	sound/soc/sti/uniperif_player.c:959:30: warning: symbol
> 		'uni_player_dai_ops' was not declared. Should it be static?
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Thanks for this one also
acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Br
Arnaud
