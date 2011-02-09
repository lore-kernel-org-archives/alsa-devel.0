From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: WL1273 FM Radio driver...
Date: Wed, 09 Feb 2011 09:22:45 +0200
Message-ID: <1297236165.15320.70.camel@masi.mnp.nokia.com>
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
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 378B4103851
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 08:23:03 +0100 (CET)
In-Reply-To: <4D5122CF.3010403@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Chehab <mchehab@redhat.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "ext Bensaid, Selma" <selma.bensaid@intel.com>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, ext@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-08 at 13:02 +0200, Peter Ujfalusi wrote:
> > For both configuration we have a set of HCI commands to configure the FM audio 
> > path and one of my concerns is to know if the wl1273_codec should handle the audio path configuration 
> > and the switch between FM and BT SCO?
> 
> It would be better if the codec could handle the configuration,
> depending on which DAI is in use. If we can send HCI commands from
> kernel, I think that would be the cleanest way.

Yes, I would have done just that - and we talked a lot about it locally
- if I had known how to do it. I started to work on it and also talked
to some BT people but it didn't seem feasible at the time. Advice
welcome of course...

Cheers,
Matti
