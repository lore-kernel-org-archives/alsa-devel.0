From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 13:32:08 +0100
Message-ID: <20090508123207.GA12895@sirena.org.uk>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<1241763077-6851-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090508094044.0c85e86a.jhnikula@gmail.com>
	<200905081456.50445.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA581038CA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 14:32:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905081456.50445.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 02:56:50PM +0300, Peter Ujfalusi wrote:

> Realistically we can not add 2581ms delay to the headsetl_event function...
> We could keep the VMID enabled all the time (which increases the idle power 
> consumption by ~0.001A), but then the muting of the headset 

Generally you want to leave VMID up all the time for exactly this reason
- ramping it cleanly with that generation of hardware just takes too
long to do it regularly during normal operation.

> (HS_POP_GAIN:HSL_GAIN, HSR_GAIN = 0) will give the 'tuck'...

Have you tried ramping the gain down gradually?  DAPM can do that for you
automatically if the volume control is attached to the PGA.

> In power consumption the difference between
> HS_POP_GAIN:HSL_GAIN, HSR_GAIN == 0 and
> HS_POP_GAIN:HSL_GAIN, HSR_GAIN != 0 is about ~0.01A, which is significant in 
> my opinion.

Yup, that's definitely going to be noticable.

> Using a timer to finish the ramp down?

How well does the device cope with aborting the ramp down?  If it can
handle it then that seems like a reasonable approach.  Othwerise it's
sounding like you may have to give people the option of either living
the pop or having the very slow ramp.
