From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031 codec - adding
	jack	detection/reporting
Date: Thu, 3 Feb 2011 23:03:04 +0000
Message-ID: <20110203230304.GA11433@sirena.org.uk>
References: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
	<20110203160640.GD2576@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FC78103AD5
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 00:03:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110203160640.GD2576@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 03, 2011 at 04:06:40PM +0000, Mark Brown wrote:
> On Thu, Feb 03, 2011 at 04:56:22PM +0530, Harsha Priya wrote:

> > +	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
> > +	if (jack_msg->intr_id & 0x1) {
> > +		pr_debug("short_push detected\n");
> > +		mask = status = SND_JACK_BTN_0;
> > +	} else if (jack_msg->intr_id & 0x2) {
> > +		pr_debug("long_push detected\n");
> > +		mask = status = SND_JACK_BTN_1;

> Shouldn't this be using a mask of BTN_0 and BTN_1 for both buttons, they
> can't be detected simultaneously?

By the way, this logic for reporting the buttons separately to the
detection of the headset/headphone status is something that should be
pulled out into generic code as the same mechanism is going to be needed
by anything using voltage based detection.
