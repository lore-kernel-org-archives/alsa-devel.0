From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Fix a double unlock in
 pcm512x_digital_mute()
Date: Fri, 21 Dec 2018 15:51:16 +0200
Message-ID: <70125712-3f2a-3ff9-a8a2-61018dd6ba1c@gmail.com>
References: <20181221091120.GG2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B06267ABE
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:51:19 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id q18so5335238wrx.9
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 05:51:19 -0800 (PST)
In-Reply-To: <20181221091120.GG2735@kadam>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/21/18 11:11 AM, Dan Carpenter wrote:
> We accidentally call mutex_unlock(&pcm512x->mutex); twice in a row.
> 
> I re-wrote the error handling to use "goto unlock;" instead of returning
> directly.  Hopefully, it makes the code a little simpler.
> 
> Fixes: 3500f1c589e9 ("ASoC: pcm512x: Implement the digital_mute interface")
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>
> ---
>   sound/soc/codecs/pcm512x.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Dimitris Papavasiliou <dpapavas@gmail.com>
