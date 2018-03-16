From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH -next] ASoC: wm8400: Use
	devm_snd_soc_register_component()
Date: Fri, 16 Mar 2018 09:21:50 +0000
Message-ID: <20180316092150.osexp6amtg3utvhm@localhost.localdomain>
References: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 76CBA267475
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 10:21:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2018 at 07:32:07AM +0000, Wei Yongjun wrote:
> Since the remove callback is removed, the snd_soc_unregister_component()
> is missing when remove device. Using devm_snd_soc_register_component()
> instead of snd_soc_register_component().
> 
> Fixes: 10dc44c6462d ("ASoC: wm8400: replace codec to component")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Thanks for spotting this.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
