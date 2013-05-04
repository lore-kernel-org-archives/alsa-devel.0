From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Sat, 4 May 2013 17:25:45 -0300
Message-ID: <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 94AAE261A55
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2013 22:25:46 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id kw10so2235398vcb.23
 for <alsa-devel@alsa-project.org>; Sat, 04 May 2013 13:25:45 -0700 (PDT)
In-Reply-To: <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, zengzm.kernel@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sat, May 4, 2013 at 3:47 PM, Fabio Estevam <festevam@gmail.com> wrote:

> I will try to investigate the power down and LDO workaround as suggested.

If I use a the kernel provided by Freescale the codec reset issue does
not happen.

I see this commit from Freescale kernel that workarounds exactly the same issue:

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/sound/soc/codecs/sgtl5000.c?h=imx_3.0.35_1.1.0&id=2f7d47e760725d33f6b2eb01024b800d64ff8944

It seems that caching is broking with this codec.

If this is true, should we go with the proposal of this RFC patch?
