From: Sergej Sawazki <ce3a@gmx.de>
Subject: ASoC: codec register dump in debugfs
Date: Fri, 29 May 2015 09:16:56 +0200
Message-ID: <55681268.1050508@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 277EF260415
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 09:16:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear all,

please correct me if I am wrong. Since the codec drivers have been
converted to direct regmap API usage, it is not common to set the
following snd_soc_codec_driver struct members:

    .reg_cache_size
    .reg_word_size

However, the functions soc_codec_reg_show() and format_register_str()
(responsible for formating and printing the codec register dumps to
debugfs) depend on these members.

I'm writing a ASoC machine driver. The board has two wm8741 codecs.
I would like to see the codec register dumps in debugfs.

eg:
cat /sys/kernel/debug/asoc/<card_name>/codec\:wm8741.1-001a/codec_reg
cat /sys/kernel/debug/asoc/<card_name>/codec\:wm8741.1-001b/codec_reg

Is it OK to set the above mentioned members in a codec driver to
"enable" the register dump output?
Or should we refactor the above mentioned functions to use the regmap
API?
Or am I missing something?

Thanks,
Sergej
