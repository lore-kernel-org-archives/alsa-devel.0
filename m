From: <wen.yang99@zte.com.cn>
Subject: Re:
	=?utf-8?q?=5B2/2=5D_ASoC=3A_samsung=3A_odroid=3A_fix?=
	=?utf-8?q?_a_double-free_issue_for_cpu=5Fdai?=
Date: Mon, 15 Jul 2019 09:49:13 +0800 (CST)
Message-ID: <201907150949139435825@zte.com.cn>
References: <4545ce50-493c-8faa-fdcd-5aee3ca30792@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7ED09F800C6
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 03:49:37 +0200 (CEST)
In-Reply-To: <4545ce50-493c-8faa-fdcd-5aee3ca30792@web.de>
References: 1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn,
 4545ce50-493c-8faa-fdcd-5aee3ca30792@web.de
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Markus.Elfring@web.de
Cc: wang.yi59@zte.com.cn, alsa-devel@alsa-project.org, xue.zhihong@zte.com.cn, lgirdwood@gmail.com, sbkim73@samsung.com, tiwai@suse.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org, broonie@kernel.org, s.nawrocki@samsung.com, cheng.shengyu@zte.com.cn
List-Id: alsa-devel@alsa-project.org

> > The cpu_dai variable is still being used after the of_node_put() call,
> 
> Such an implementation detail is questionable.
> https://wiki.sei.cmu.edu/confluence/display/c/MEM30-C.+Do+not+access+freed+memory
> 
> 
> > which may result in double-free:
> 
> This consequence is also undesirable.
> https://cwe.mitre.org/data/definitions/415.html
> 
> 
> Now I wonder if two update steps are really appropriate as a fix
> instead of using a single update step for the desired correction
> in this software module.
> Should a commit (including previous ones) usually be correct by itself?

Thanks.
These two updates fix two different bugs.

One of them is the use-after-free issue introduced by bc3cf17b575a:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=bc3cf17b575a7a97b4af7ddcf86133175da7a582

-       ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+       cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
+       of_node_put(cpu);
+       of_node_put(codec);
+
+       ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
        if (ret < 0)
                goto err_put_codec_n;

and the other is the double-free issue introduced by d832d2b246c5:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/samsung/odroid.c?id=d832d2b246c516eacb2d0ba53ec17ed59c3cd62b#n318
and n303, n308.

So we sent two patches to fix them separately.

--
Regards,
Wen
