From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031 codec - adding jack
 detection/reporting
Date: Fri, 4 Feb 2011 14:05:05 +0000
Message-ID: <20110204140504.GA5393@opensource.wolfsonmicro.com>
References: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
	<20110203160640.GD2576@opensource.wolfsonmicro.com>
	<20110203230304.GA11433@sirena.org.uk>
	<98769532B4BB14429434178695419EAE08C107FB23@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26CAC103B0C
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 15:04:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C107FB23@bgsmsx501.gar.corp.intel.com>
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

On Fri, Feb 04, 2011 at 09:20:52AM +0530, Harsha, Priya wrote:

> >By the way, this logic for reporting the buttons separately to the
> >detection of the headset/headphone status is something that should be
> >pulled out into generic code as the same mechanism is going to be needed
> >by anything using voltage based detection.

> But here, we don't do button press detection based on voltage. We get a
> separate value being set in register when interrupt is generated. In the
> generic code of adding zones and retrieving type, we can add the button press.

Right, but one common way of doing multiple buttons is to use the
detection of the short to trigger an ADC reading and then look at the
value.
