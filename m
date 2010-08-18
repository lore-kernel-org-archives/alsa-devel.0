From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v6 0/1] A codec driver for the TI WL1273 FM
	Radio.
Date: Wed, 18 Aug 2010 12:53:35 +0300
Message-ID: <1282125215.14489.114.camel@masi.mnp.nokia.com>
References: <1282045280-16696-1-git-send-email-matti.j.aaltonen@nokia.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E41342449B
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 11:54:10 +0200 (CEST)
In-Reply-To: <1282045280-16696-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi.

Haven't heard from you in a while. Have you silently accepted the codec
or is there still something to change?

Cheers,
Matti


On Tue, 2010-08-17 at 13:41 +0200, Aaltonen Matti.J (Nokia-MS/Tampere)
wrote:
> Hello.
> 
> I didn't get any comments to the latest patch set. But now I've had
> a change to test the codec in multi component environment. I had
> to change the get_format function because the number of channels couldn't
> be used for determining the format. Also I added a few audio related 
> defines to the header file.
> 
> Thank You.
> 
> Matti J. Aaltonen (1):
>   ASoC: TI WL1273 FM Radio Codec.
> 
>  sound/soc/codecs/wl1273.c |  553 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wl1273.h |  101 ++++++++
>  2 files changed, 654 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/wl1273.c
>  create mode 100644 sound/soc/codecs/wl1273.h
> 
