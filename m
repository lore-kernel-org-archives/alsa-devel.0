From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2] ASoC: tlv320aic31xx: Don't call kfree
 for memory allocated by devm_kzalloc
Date: Mon, 17 Mar 2014 09:22:53 +0200
Message-ID: <5326A2CD.7060808@ti.com>
References: <1394982385.19788.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 91088260786
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 08:22:57 +0100 (CET)
In-Reply-To: <1394982385.19788.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/16/2014 05:06 PM, Axel Lin wrote:
> The kfree call is not necessary, but we need to call snd_soc_unregister_codec()
> in remove().
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Oops, that is a bad one. Thanks!

Acked-by: Jyri Sarha <jsarha@ti.com>

ps. I found another not as serious bug when I did unload testing with 
this patch. I'll mail a patch shortly.
