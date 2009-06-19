From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Fri, 19 Jun 2009 10:41:07 +0100
Message-ID: <1245404467.21421.275.camel@vega.slimlogic.co.uk>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	<1245404150.21421.272.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CC88244BB
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 11:41:11 +0200 (CEST)
In-Reply-To: <1245404150.21421.272.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-06-19 at 10:35 +0100, Liam Girdwood wrote:
> On Fri, 2009-06-19 at 17:28 +0800, Barry Song wrote:
> > 1. add AD1938 codec driver                   (codec)
> > 2. add blackfin SPORT-TDM DAI and PCM driver (platform)
> > 3. add bf5xx board with AD1938 driver        (machine)
> > Signed-off-by: Barry Song <21cnbao@gmail.com>
> > ---
> >  include/sound/soc-dai.h            |    1 +
> >  sound/soc/blackfin/Kconfig         |   46 +++-
> >  sound/soc/blackfin/Makefile        |    6 +
> >  sound/soc/blackfin/bf5xx-ad1938.c  |  178 ++++++++++++
> >  sound/soc/blackfin/bf5xx-tdm-pcm.c |  330 ++++++++++++++++++++++
> >  sound/soc/blackfin/bf5xx-tdm-pcm.h |   21 ++
> >  sound/soc/blackfin/bf5xx-tdm.c     |  295 +++++++++++++++++++
> >  sound/soc/blackfin/bf5xx-tdm.h     |   14 +
> >  sound/soc/codecs/Kconfig           |    4 +
> >  sound/soc/codecs/Makefile          |    2 +
> >  sound/soc/codecs/ad1938.c          |  548 ++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/ad1938.h          |   68 +++++
> >  12 files changed, 1512 insertions(+), 1 deletions(-)
> >  create mode 100644 sound/soc/blackfin/bf5xx-ad1938.c
> >  create mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.c
> >  create mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.h
> >  create mode 100644 sound/soc/blackfin/bf5xx-tdm.c
> >  create mode 100644 sound/soc/blackfin/bf5xx-tdm.h
> >  create mode 100644 sound/soc/codecs/ad1938.c
> >  create mode 100644 sound/soc/codecs/ad1938.h
> > 
> 
> Could you break this patch into smaller chunks. This should make it
> easier to review and apply.

and also add a description for each patch in your series. 

Thanks

Liam
