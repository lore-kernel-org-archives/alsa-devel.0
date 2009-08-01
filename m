From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Sat, 1 Aug 2009 08:45:31 +0530
Message-ID: <98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
	<20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id DFDAE2480E
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 05:15:36 +0200 (CEST)
In-Reply-To: <20090717101804.GD3439@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In my probe function, after adding the controls, I added the following code

	retval = snd_jack_new(intelmaddata->card, "Headphone",
				SND_JACK_HEADPHONE, &jack);
	if (retval < 0)
		return retval;
	jack->private_data = jack;
	snd_jack_report(jack, jack->type);

	retval = snd_jack_new(intelmaddata->card, "Headset",
				SND_JACK_HEADSET, &jack);
	if (retval < 0)
		return retval;
	jack->private_data = jack;
	snd_jack_report(jack, jack->type);

But I do not see any jacks in /dev/input.... Am I missing anything?

Thanks,
Harsha.
>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Friday, July 17, 2009 3:48 PM
>To: Harsha, Priya
>Cc: Koul, Vinod; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Fri, Jul 17, 2009 at 12:31:25PM +0530, Harsha, Priya wrote:
>
>> I was looking into creating jack sense device. I see that I can create
>> jack sense for headphones/headset/mic etc,. but if I want to send events
>> like long press and short press of headset keys, can I use this same
>> framework in someway? Is there any way to event these kinds of actions
>> to user space through ALSA?
>
>The intention was that buttons would be reported as normal buttons,
>probably BTN_MISC.  Nobody has merged a driver with short detection yet
>so it's not been added to the jack API yet but that's a fairly trivial
>mapping.
>
>Within the input API buttons just have pressed and released states so as
>unless there's something I'm not aware of you'll need to manually create
>different press lengths with a timer.
