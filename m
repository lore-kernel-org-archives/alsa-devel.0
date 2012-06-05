From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: McBSP in TDM for audio codec
Date: Tue, 05 Jun 2012 15:52:55 +0300
Message-ID: <4FCE0127.8080404@ti.com>
References: <CADU0PKEAQtEP_26YwyiKXg0tVO=aAH9fDUuk7cohNG51nUHRFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
	[74.125.149.247])
	by alsa0.perex.cz (Postfix) with ESMTP id D7FF62464D
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 14:53:00 +0200 (CEST)
Received: by laai10 with SMTP id i10so6941906laa.27
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2012 05:52:58 -0700 (PDT)
In-Reply-To: <CADU0PKEAQtEP_26YwyiKXg0tVO=aAH9fDUuk7cohNG51nUHRFA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: learnom learnom <learnom1@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 06/05/2012 02:37 AM, learnom learnom wrote:

> Hi All,
> =

> I have to support 4 channels in I2S format in TDM mode.
> Processor: OMAP 3703

>

> If any one have any idea on how to go about this. Please let me know.


The McBSP driver currently supports TDM mode (DSP mode) up to 16 channels.
It should work out of box.
Take a look at the following drivers:
sound/soc/omap/omap-mcbsp.c
sound/soc/codecs/twl4030.c
sound/soc/omap/omap3beagle.c

for reference. The Beagle have twl4030 codec and it is possible to use
playback with 4 channels.

-- =

P=E9ter
