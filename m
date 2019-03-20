From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: lochnagar: Add device tree
	binding document
Date: Wed, 20 Mar 2019 17:05:29 +0000
Message-ID: <20190320170529.GV46536@ediswmail.ad.cirrus.com>
References: <20190320142813.12745-1-ckeepax@opensource.cirrus.com>
 <20190320165251.GC27518@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70303F80791
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 18:05:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190320165251.GC27518@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 20, 2019 at 04:52:51PM +0000, Mark Brown wrote:
> On Wed, Mar 20, 2019 at 02:28:12PM +0000, Charles Keepax wrote:
> 
> > +  - clock-names : Must include the following clocks:
> > +      "ln-sound-mclk" Master clock source for the sound card, should
> > +      normally be set to LOCHNAGAR_SOUNDCARD_MCLK provided by the
> > +      Lochnagar clock driver.
> 
> Why the namespacing on the clock name here?

I think this is just a hang over from when these clocks were not
handled through DT and thus had to have the same name as was used
in the clock driver. Agree it is redundant now and will remove,
maybe even just mclk should be fine I guess, as the sound is
kinda redundant as well.

Thanks,
Charles
