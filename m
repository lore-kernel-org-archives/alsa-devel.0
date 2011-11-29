From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/8] ASoC: Convert au1x directory to
	module_platform_driver
Date: Tue, 29 Nov 2011 07:28:17 +0100
Message-ID: <CAOLZvyEWEKRKyCEpoOFh+kHH7D1k+rONbro+H9eFg7BbtwpPcQ@mail.gmail.com>
References: <1322186745.8878.1.camel@phoenix> <1322186819.8878.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0E0662442A
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 07:28:58 +0100 (CET)
Received: by yws1 with SMTP id 1so3527344yws.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:28:58 -0800 (PST)
In-Reply-To: <1322186819.8878.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 25, 2011 at 3:06 AM, Axel Lin <axel.lin@gmail.com> wrote:
> Factor out some boilerplate code.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0sound/soc/au1x/db1000.c =A0| =A0 13 +------------
> =A0sound/soc/au1x/db1200.c =A0| =A0 13 +------------
> =A0sound/soc/au1x/dbdma2.c =A0| =A0 13 +------------
> =A0sound/soc/au1x/dma.c =A0 =A0 | =A0 13 +------------
> =A0sound/soc/au1x/i2sc.c =A0 =A0| =A0 13 +------------
> =A0sound/soc/au1x/psc-i2s.c | =A0 13 +------------
> =A06 files changed, 6 insertions(+), 72 deletions(-)

[snip]

I'm sort of on the fence about the point of all this, but it looks nice, so:

Acked-by: Manuel Lauss <manuel.lauss@googlemail.com>


Thank you!
        Manuel Lauss
