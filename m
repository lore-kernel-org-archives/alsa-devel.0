From: learnom learnom <learnom1@gmail.com>
Subject: Re: McBSP in TDM for audio codec
Date: Tue, 5 Jun 2012 18:56:46 -0700
Message-ID: <CADU0PKGmx=dqdUVxvTUDKr2qG_3+3yXcWeKTb__50ayjPHgV+A@mail.gmail.com>
References: <CADU0PKEAQtEP_26YwyiKXg0tVO=aAH9fDUuk7cohNG51nUHRFA@mail.gmail.com>
	<4FCE0127.8080404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9937C243E0
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 03:56:46 +0200 (CEST)
Received: by lagw12 with SMTP id w12so4132086lag.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2012 18:56:46 -0700 (PDT)
In-Reply-To: <4FCE0127.8080404@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,
Thanks for the information.
I was able to setup for multiple channel(by setting up xcera register).
Iam able to get proper frame synchronization clock and the data is
transmitted on channel0 in A partition(block0).

I want to control these channel0, 1, 2, 3 independently.
For example, lets say,
1) If I want to transmit the data in channel 1 only, i want to see the
channel0 null, channel1 with data, channel 2 null, channel 3 null.

2)I want to transmit data at the same time, channel 1 (data) , channel2
(Data), channel3 data, channel(data).

Can you please let me know how to recognize that the user is sending from
which channel, and how to setup for these two scenarios.
Thanks,
learnom





On Tue, Jun 5, 2012 at 5:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>wrote:

> Hi,
>
> On 06/05/2012 02:37 AM, learnom learnom wrote:
>
> > Hi All,
> >
> > I have to support 4 channels in I2S format in TDM mode.
> > Processor: OMAP 3703
>
> >
>
> > If any one have any idea on how to go about this. Please let me know.
>
>
> The McBSP driver currently supports TDM mode (DSP mode) up to 16 channels.
> It should work out of box.
> Take a look at the following drivers:
> sound/soc/omap/omap-mcbsp.c
> sound/soc/codecs/twl4030.c
> sound/soc/omap/omap3beagle.c
>
> for reference. The Beagle have twl4030 codec and it is possible to use
> playback with 4 channels.
>
> --
> P=E9ter
>
