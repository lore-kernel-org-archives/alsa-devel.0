From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] ASoC: mediatek: mt2701: drop
 unnessary snd_soc_unregister_component()
Date: Fri, 16 Mar 2018 11:47:12 +0300
Message-ID: <20180316084712.hh4ll7hfsncqqsos@mwanda>
References: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 1751F267274
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 09:52:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, Ryder Lee <ryder.lee@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2018 at 07:31:56AM +0000, Wei Yongjun wrote:
> It's not necessary to unregister a component registered
> with devm_snd_soc_register_component().
> 
> Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to componen")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>


This fixes a double free on unload, right?

regards,
dan carpenter
