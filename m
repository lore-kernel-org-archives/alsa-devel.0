From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Failed to set cache compression type
Date: Mon, 2 Jun 2014 11:13:34 -0300
Message-ID: <CAOMZO5D6WAPdV371v6sVc46TcfUZFNGL2VUzBLNfkLfX83e7zA@mail.gmail.com>
References: <CAOMZO5Cj=qrrH_nWhCM4-63GPqfgpL1k=Q53z8cDDk3_TpUzBA@mail.gmail.com>
 <538C840A.2000307@linux.intel.com> <538C85C3.5020808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id E94BA2652E7
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 16:13:35 +0200 (CEST)
Received: by mail-vc0-f182.google.com with SMTP id id10so5164705vcb.13
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 07:13:35 -0700 (PDT)
In-Reply-To: <538C85C3.5020808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 2, 2014 at 11:10 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> I think snd_soc_cache_init() should return 0 rather than -EINVAL if reg_size
> is 0.

Yes, this fixes the issue:

--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -73,7 +73,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
        reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;

        if (!reg_size)
-               return -EINVAL;
+               return 0;

        mutex_init(&codec->cache_rw_mutex);
