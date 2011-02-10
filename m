From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: WL1273 FM Radio driver...
Date: Thu, 10 Feb 2011 12:03:43 +0200
Message-ID: <1297332223.15320.95.camel@masi.mnp.nokia.com>
References: <1297075922.15320.31.camel@masi.mnp.nokia.com>
	<4D4FDED0.7070008@redhat.com>
	<20110207120234.GE10564@opensource.wolfsonmicro.com>
	<4D4FEA03.7090109@redhat.com>
	<20110207131045.GG10564@opensource.wolfsonmicro.com>
	<4D4FF821.4010701@redhat.com>
	<20110207135225.GJ10564@opensource.wolfsonmicro.com>
	<1297088242.15320.62.camel@masi.mnp.nokia.com>
	<4D501704.6060504@redhat.com> <4D5109B3.60504@nokia.com>
	<2A84145621092446B6659B8A0F28E26F47010C29F1@irsmsx501.ger.corp.intel.com>
	<4D5122CF.3010403@nokia.com>
	<1297236165.15320.70.camel@masi.mnp.nokia.com>
	<2A84145621092446B6659B8A0F28E26F4703CC3968@irsmsx501.ger.corp.intel.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id BDBA4103981
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 11:04:05 +0100 (CET)
In-Reply-To: <2A84145621092446B6659B8A0F28E26F4703CC3968@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mauro Carvalho Chehab <mchehab@redhat.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hello.

On Thu, 2011-02-10 at 09:35 +0000, ext Bensaid, Selma wrote:
> > On Tue, 2011-02-08 at 13:02 +0200, Peter Ujfalusi wrote:
> > > > For both configuration we have a set of HCI commands to configure the FM
> > audio
> > > > path and one of my concerns is to know if the wl1273_codec should handle
> > the audio path configuration
> > > > and the switch between FM and BT SCO?
> > >
> > > It would be better if the codec could handle the configuration,
> > > depending on which DAI is in use. If we can send HCI commands from
> > > kernel, I think that would be the cleanest way.
> > 
> > Yes, I would have done just that - and we talked a lot about it locally
> > - if I had known how to do it. I started to work on it and also talked
> > to some BT people but it didn't seem feasible at the time. Advice
> > welcome of course...
> > 
> > Cheers,
> > Matti
> > 
> Hi,
> Below the set of HCI commands that we have identified to configure the FM and BT SCO audio paths:
> -	External Audio Connection
> 	o	START BT SCO Connection
> 		# BT audio Path PCM  &  FM audio Path I2S
> 		> hcitool cmd 0x3F 0X195 FF FF FF FF FF FF FF FF 01 02 FF 00 00 00 00 
> 		# BT AUDIO Codec Configuration: MASTER
> 		> hcitool cmd 0x3F 0X106 00 03 00 40 1F 00 00 01 00 00 00 00 10 00 02 00 00 10 00 02 00 01 00 00 00 00 00 00 00 00 00 00
> 
> 	o	STOP BT SCO Connection
> 		# BT AUDIO Codec Configuration: SLAVE
> 		> hcitool cmd 0x3F 0X106 00 03 01 40 1F 00 00 01 00 00 00 00 10 00 02 00 00 10 00 02 00 01 00 00 00 00 00 00 00 00 00 00
> 
>  
> -	Internal Audio Connection
> 	o	START BT SCO Connection
> 		# BT audio Path PCM 
> 		# FM audio Path None
> 		> hcitool cmd 0x3F 0X195  FF FF FF FF FF FF FF FF 01 00 FF 00 00 00 00 
> 		# BT AUDIO Codec Configuration: MASTER
> 		> hcitool cmd 0x3F 0X106 00 03 00 40 1F 00 00 01 00 00 00 00 10 00 02 00 00 10 00 02 00 01 00 00 00 00 00 00 00 00 00 00
> 
> 	o	STOP BT SCO Connection
> 		# BT audio Path None & FM audio Path None
> 		> hcitool cmd 0x3F 0X195  FF FF FF FF FF FF FF FF 00 00 FF 00 00 00 00 
> 
> 	o	FM Audio Path configuration
> 		# BT audio Path None  & FM audio Path PCM
> 		> hcitool cmd 0x3F 0X195  FF FF FF FF FF FF FF FF 00 01 FF 00 00 00 00
>  
> Please note that the BT SCO Codec settings are platform specific.
> Selma.

We know these messages, they are mentioned in the documentation and we
use them already, but we send them from the user space. The problem is
how to send the messages from the driver within the kernel.

Thanks,
Matti

> 
> 
> 
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, 
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
