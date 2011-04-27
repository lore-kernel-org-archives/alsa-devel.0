From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: Add more natural support for
	no-DMA DAIs
Date: Thu, 28 Apr 2011 01:04:43 +0530
Message-ID: <BANLkTiku4CPia8u_QvjyAnxVDeiF1mWrbA@mail.gmail.com>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1303925257-26920-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A0FAF103936
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 21:34:46 +0200 (CEST)
Received: by bwz10 with SMTP id 10so1920761bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 12:34:43 -0700 (PDT)
In-Reply-To: <1303925257-26920-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 27, 2011 at 10:57 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Since we can now support multiple platforms allow machines to not specify
> a platform in a DAI link. Since the rest of the code requires that we have
> a struct device for all objects we do this by substituting in a dummy
> device that we register automatically.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

2-5 as well...

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
