From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [RESEND PATCH 0/6] ASoC: Mediatek: Add support for
 MT8183 SoC and MT6358 Codec
Date: Sat, 26 Jan 2019 20:55:39 +0800
Message-ID: <CANMq1KDAy0=yF+90MvamdfWu4uuTf8xAwczZ33sVpxDjo9OVSQ@mail.gmail.com>
References: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00629267418
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 13:55:51 +0100 (CET)
Received: by mail-qt1-f193.google.com with SMTP id r14so13746867qtp.1
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 04:55:51 -0800 (PST)
In-Reply-To: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shunli Wang <shunli.wang@mediatek.com>
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, Mark Brown <broonie@kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 26, 2019 at 3:45 PM Shunli Wang <shunli.wang@mediatek.com> wrote:
>
> This patch adds support for Mediatek AFE for MT8183 SoC and codec for MT6358.
> The patch is based on broonie tree "for-next" branch.
> (Because it seems ALSA-DEVEL have not received previous mail,
> this is a resend mail for this patchset.)
>
> Shunli Wang (6):
>   ASoC: mediatek: mt8183: add platform driver
>   ASoC: mediatek: mt8183: add audio afe document
>   ASoC: mediatek: mt6358: add codec driver
>   ASoC: mediatek: mt6358: add codec document
>   ASoC: mediatek: mt8183: add mt8183-mt6358 machine driver
>   ASoC: mediatek: add document for mt8183-mt6358

Shunli, the first 4 of these patches were already applied here:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next

Can you rebase on that tree and resend only the missing ones (after
fixing the build errors that Mark mentionned)?


>  Documentation/devicetree/bindings/sound/mt6358.txt |   18 +
>  .../devicetree/bindings/sound/mt8183-afe-pcm.txt   |   36 +
>  .../devicetree/bindings/sound/mt8183-mt6358.txt    |   12 +
>  sound/soc/codecs/Kconfig                           |    7 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/mt6358.c                          | 2336 ++++++++++++++++++++
>  sound/soc/codecs/mt6358.h                          | 2314 +++++++++++++++++++
>  sound/soc/mediatek/Kconfig                         |   20 +
>  sound/soc/mediatek/Makefile                        |    1 +
>  sound/soc/mediatek/mt8183/Makefile                 |   13 +
>  sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |  611 +++++
>  sound/soc/mediatek/mt8183/mt8183-afe-clk.h         |   38 +
>  sound/soc/mediatek/mt8183/mt8183-afe-common.h      |  108 +
>  sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         | 1237 +++++++++++
>  sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |  501 +++++
>  sound/soc/mediatek/mt8183/mt8183-dai-hostless.c    |  118 +
>  sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         | 1040 +++++++++
>  sound/soc/mediatek/mt8183/mt8183-dai-pcm.c         |  318 +++
>  sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         |  639 ++++++
>  sound/soc/mediatek/mt8183/mt8183-interconnection.h |   33 +
>  sound/soc/mediatek/mt8183/mt8183-mt6358.c          |  208 ++
>  sound/soc/mediatek/mt8183/mt8183-reg.h             | 1666 ++++++++++++++
>  22 files changed, 11276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8183-mt6358.txt
>  create mode 100644 sound/soc/codecs/mt6358.c
>  create mode 100644 sound/soc/codecs/mt6358.h
>  create mode 100644 sound/soc/mediatek/mt8183/Makefile
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.h
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-common.h
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-adda.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-interconnection.h
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-mt6358.c
>  create mode 100644 sound/soc/mediatek/mt8183/mt8183-reg.h
>
> --
> 1.9.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
