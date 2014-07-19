From: gsantosh@codeaurora.org
Subject: Re: Question on fe_dai_open
Date: Sat, 19 Jul 2014 13:14:28 -0000
Message-ID: <e33632e2e5e1e5f02446c265ea6dcc9f.squirrel@www.codeaurora.org>
References: <24f2c41bc1a9ac326b94ef14ce1bb1bf.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 84973261A33
 for <alsa-devel@alsa-project.org>; Sat, 19 Jul 2014 15:14:31 +0200 (CEST)
In-Reply-To: <24f2c41bc1a9ac326b94ef14ce1bb1bf.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gsantosh@codeaurora.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi All,

Please help me on this question.

Regards,
Santosh M G.



> Hi All,
>
> In the following function
>
> dpcm_fe_dai_open
>
> Why the code is proceeding further if dpcm_path_get returns zero,
> if dpcm_path_get returns zero implies there is no vaild path setup.
>
> technically we should return from the function when there is no valid path
> setup, still we proceed further de-referencing the pointer at the exit of
> this function through dpcm_path_put(&list);
>
> please let me know why we are not returning when dpcm_path_get returns
> zero.
>
>
> static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
> {
> ....
> 	if (dpcm_path_get(fe, stream, &list) <= 0) {
> 		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
> 			fe->dai_link->name, stream ? "capture" :
>                                           "playback");
>
>             /*we need to return if there is no vaild paths available*/
> 	}
> ....
> 	dpcm_path_put(&list);
> }
>
> Regards
> Santosh M G
>
