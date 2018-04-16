From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH 1/5] ASoC: add mt6351 codec driver
Date: Mon, 16 Apr 2018 08:42:03 +0800
Message-ID: <1523839323.14415.1.camel@mtksdaap41>
References: <20180413090242.4211-2-kaichieh.chuang@mediatek.com>
 <201804141214.KHhwp7O4%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 00C8A267168
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 02:42:10 +0200 (CEST)
In-Reply-To: <201804141214.KHhwp7O4%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

>    sound/soc/codecs/mt6351.c: In function 'mt_hp_event':
> >> sound/soc/codecs/mt6351.c:912:8: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>       else if (priv->hp_en_counter < 0)
>            ^~
>    sound/soc/codecs/mt6351.c:918:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
>        hp_zcd_disable(codec);
>        ^~~~~~~~~~~~~~
I have sent v2 patch set to fix this, sorry for the inconvenience.
