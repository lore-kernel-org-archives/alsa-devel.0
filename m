From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Samsung: Debug PCM
 snd_soc_dai_driver registration
Date: Fri, 10 Sep 2010 12:47:54 +0100
Message-ID: <20100910114754.GJ7259@rakim.wolfsonmicro.main>
References: <1284104465-17287-1-git-send-email-jassisinghbrar@gmail.com>
	<20100910095438.GD3068@rakim.wolfsonmicro.main>
	<AANLkTimajKCsDLPuGRoO=339BpUQ_wXn8pDsC+7ErzET@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71BBB1039C2
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:47:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimajKCsDLPuGRoO=339BpUQ_wXn8pDsC+7ErzET@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, sw.youn@samsung.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 08:24:03PM +0900, Jassi Brar wrote:
> 2010/9/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > You should be able to use the id field rather than adding the number to
> > the names here.

> But the id assignment was removed by Liam's patch, maybe unintentional ?

Most likely an error - earlier versions of the patches didn't have the
separate ID field IIRC.
