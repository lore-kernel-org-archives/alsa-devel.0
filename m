From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv3 0/3] ASoC: simple-card: simplify the code.
Date: Wed, 3 Sep 2014 10:23:38 +0800
Message-ID: <1409711021-19277-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Any comment and advice are welcome.

Change in v3:
- Fix binding from Jean's comment.
- Remove 'ASoC: simple-card: add asoc_simple_card_fmt_master() to simplify the code.'
  and will send it separately later.

Change in v2:
- Maintian compatibility with the old DTs.

Change in v1:
- Add simple-card dts node patches.
- Fix format parsing bug from Jean-Francois's comment.
- Rebase to Kuninori-san's newest changes in next branch.




Xiubo Li (3):
  ASoC: simple-card: Merge single and muti DAI link(s) code.
  ASoC: simple-card: Adjust the comments of simple card.
  ASoC: simple-card: binding: update binding to support the new style.

 .../devicetree/bindings/sound/simple-card.txt      | 183 ++++++++++++++-------
 sound/soc/generic/simple-card.c                    |  70 ++++----
 2 files changed, 161 insertions(+), 92 deletions(-)

-- 
1.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
