From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031 codec - adding jack
 detection/reporting
Date: Fri, 4 Feb 2011 14:10:03 +0000
Message-ID: <20110204141003.GB5393@opensource.wolfsonmicro.com>
References: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
	<20110203160640.GD2576@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE08C107FDA5@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14F79103B0C
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 15:09:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C107FDA5@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 04, 2011 at 11:19:24AM +0530, Harsha, Priya wrote:

> >> +	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
> >> +	if (jack_msg->intr_id & 0x1) {
> >> +		pr_debug("short_push detected\n");
> >> +		mask = status = SND_JACK_BTN_0;
> >> +	} else if (jack_msg->intr_id & 0x2) {
> >> +		pr_debug("long_push detected\n");
> >> +		mask = status = SND_JACK_BTN_1;

> >Shouldn't this be using a mask of BTN_0 and BTN_1 for both buttons, they
> >can't be detected simultaneously?

> No. They can't be detected simultaneously. It's the same button giving 
> Interrupts for long press and short press based on the duration of the press

In which case the driver shouldn't be using the same value for mask and
status, the two buttons are exclusive (and having the multiple
assignments in one statement isn't ideal for legibility anyway).
