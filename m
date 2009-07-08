From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Wed, 8 Jul 2009 11:14:07 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FAA81037F4
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 07:45:11 +0200 (CEST)
In-Reply-To: <20090707114227.GD14393@rakim.wolfsonmicro.main>
Content-Language: en-US
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Tuesday, July 07, 2009 5:12 PM
>To: Harsha, Priya
>Cc: Koul, Vinod; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Tue, Jul 07, 2009 at 12:05:45PM +0530, Harsha, Priya wrote:
>> >-----Original Message-----
>> >From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>
>> >ALSA core has an interface for representing jacks to user space which
>> >should be used here - see include/sound/jack.h.
>
>> Thanks for the note. I shall look into it further. Can you suggest any
>> example ALSA driver that uses this functionality so that I can have a
>
>A lot of the HDA drivers use it and there's a wrapper for ASoC too -
>it's fairly likely that if you're running a current kernel your desktop
>PC will support this interface already.  Searching the kernel source for
>snd_jack_new() should turn up everything there is at the minute.
>
>> reference. Also quick question around this, can I use this jack.h to
>> event the user space?
>
>Yes, the jacks currently appear as input devices to applications.
>Takashi was also considering adding some ALSA-specific ways of reading
>the state to go alongside these.
If I create a jack sense device, how would an application use it? Currently do we have any mechanism in ALSA to send events to user space when a jack is detected? If not, would it be ok if I stick to netlink events for now. We have a platform specific daemon that is being developed that listens on netlink events and that is why the driver sends them. 

Thanks,
Harsha
