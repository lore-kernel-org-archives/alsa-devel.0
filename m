From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Fix a double unlock in
 pcm512x_digital_mute()
Date: Fri, 21 Dec 2018 13:23:37 +0200
Message-ID: <f8f14c6a-46c2-995d-2df4-4ae821e1b895@gmail.com>
References: <20181221091120.GG2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by alsa0.perex.cz (Postfix) with ESMTP id BCFA0267ABC
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 12:23:40 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id m1so4971636wml.2
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 03:23:40 -0800 (PST)
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

Ooops...  Looks like I left a spare unlock in there.  Thanks for
catching and fixing it!

Maintainers, please let me know if there's anything I need to do
with respect to this.
