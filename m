From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to
 determine jack type
Date: Tue, 1 Feb 2011 13:22:06 +0000
Message-ID: <20110201132206.GE12743@opensource.wolfsonmicro.com>
References: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
	<20110131120826.GD5123@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE08C0FE9A4D@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43CAF244B5
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 14:22:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C0FE9A4D@bgsmsx501.gar.corp.intel.com>
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

On Tue, Feb 01, 2011 at 06:49:11PM +0530, Harsha, Priya wrote:

> >I think this is too minimal as an API for this.  There's two things I'm
> >missing here.  The major one is that there's no handling of debounce -
> >jack insertion is a very slow and very analogue process relative to CPUs
> >so taking a single reading is likely to give false measurements.

> I believe this should be part of codec driver that would make sure that it has
> determined the right adc value and then call the function to find the jack type. 

This is not in general possible - there are generally AUXADCs in many
devices, CPUs and PMICs both commonly have them, and the majority of
them just take a reading when asked to do so.  Generic software needs to
be able to handle this.

> In the sn95031 codec, this is handled in hardware with programmable debounce
> values. The default value  takes care of ensuring that the adc value is read is for
> right jack event.

That's great, but we can't rely on this in generic code.

> Later, I will add a kcontrol for the same to enable programming it.

Hrm?

> I can add a field "system_micbias" field and the ranges fields to snd_soc_jack
> structure. The machine driver can set these details when it creates a jack. The
> new API can give the jack or button type based on this range. This way its
> scalable. Will this help? Let us know, if there is a better way

Probably.
