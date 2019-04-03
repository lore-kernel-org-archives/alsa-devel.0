From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [asoc:for-5.2 101/107]
 sound/soc/sprd/sprd-pcm-compress.c:110 sprd_platform_compr_drain_notify()
 warn: variable dereferenced before check 'cstream' (see line 105)
Date: Wed, 3 Apr 2019 14:52:01 +0800
Message-ID: <CAMz4kuL2XLhd4VNF32+uDpi-E67EiWufaxxqxkgn9csqF+mpzg@mail.gmail.com>
References: <20190403064619.GI32613@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71FDBF8068A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 08:52:15 +0200 (CEST)
Received: by mail-oi1-x242.google.com with SMTP id e5so12709567oii.0
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2019 23:52:14 -0700 (PDT)
In-Reply-To: <20190403064619.GI32613@kadam>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, kbuild@01.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Apr 2019 at 14:46, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
> head:   6d5e2bf9d203e4d9e08ca2e9420c6ff22ad190af
> commit: cce1396936ef2b347d622b4d49718818eb32029d [101/107] ASoC: sprd: Add Spreadtrum audio compress offload support
>
> smatch warnings:
> sound/soc/sprd/sprd-pcm-compress.c:110 sprd_platform_compr_drain_notify() warn: variable dereferenced before check 'cstream' (see line 105)
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=cce1396936ef2b347d622b4d49718818eb32029d
> git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> git remote update asoc
> git checkout cce1396936ef2b347d622b4d49718818eb32029d
> vim +/cstream +110 sound/soc/sprd/sprd-pcm-compress.c
>
> cce13969 Baolin Wang 2019-03-27   98
> cce13969 Baolin Wang 2019-03-27   99  static int sprd_platform_compr_trigger(struct snd_compr_stream *cstream,
> cce13969 Baolin Wang 2019-03-27  100                                   int cmd);
> cce13969 Baolin Wang 2019-03-27  101
> cce13969 Baolin Wang 2019-03-27  102  static void sprd_platform_compr_drain_notify(void *arg)
> cce13969 Baolin Wang 2019-03-27  103  {
> cce13969 Baolin Wang 2019-03-27  104    struct snd_compr_stream *cstream = arg;
> cce13969 Baolin Wang 2019-03-27 @105    struct snd_compr_runtime *runtime = cstream->runtime;
>                                                                             ^^^^^^^^^^^^^^^^
>
> cce13969 Baolin Wang 2019-03-27  106    struct sprd_compr_stream *stream = runtime->private_data;
> cce13969 Baolin Wang 2019-03-27  107
> cce13969 Baolin Wang 2019-03-27  108    memset(stream->info_area, 0, sizeof(struct sprd_compr_playinfo));
> cce13969 Baolin Wang 2019-03-27  109
> cce13969 Baolin Wang 2019-03-27 @110    if (cstream)
>                                             ^^^^^^^

Sorry for my mistake. It seems no need to validate the cstream
variable here. Will fix it. Thanks.

-- 
Baolin Wang
Best Regards
