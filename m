From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031 codec - adding
	jack	detection/reporting
Date: Fri, 4 Feb 2011 09:20:52 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C107FB23@bgsmsx501.gar.corp.intel.com>
References: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
	<20110203160640.GD2576@opensource.wolfsonmicro.com>
	<20110203230304.GA11433@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 441F8103922
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 04:51:00 +0100 (CET)
In-Reply-To: <20110203230304.GA11433@sirena.org.uk>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>
>> > +	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
>> > +	if (jack_msg->intr_id & 0x1) {
>> > +		pr_debug("short_push detected\n");
>> > +		mask = status = SND_JACK_BTN_0;
>> > +	} else if (jack_msg->intr_id & 0x2) {
>> > +		pr_debug("long_push detected\n");
>> > +		mask = status = SND_JACK_BTN_1;
>
>> Shouldn't this be using a mask of BTN_0 and BTN_1 for both buttons, they
>> can't be detected simultaneously?
>
>By the way, this logic for reporting the buttons separately to the
>detection of the headset/headphone status is something that should be
>pulled out into generic code as the same mechanism is going to be needed
>by anything using voltage based detection.
But here, we don't do button press detection based on voltage. We get a
separate value being set in register when interrupt is generated. In the
generic code of adding zones and retrieving type, we can add the button press.
