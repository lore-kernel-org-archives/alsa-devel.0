From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add support for Cirrus Logic CS42L52
 LowpowerStereo Codec
Date: Fri, 26 Feb 2010 11:18:00 -0600
Message-ID: <1267204680.13721.105.camel@heelrod.ad.cirrus.com>
References: <1267142855-12854-1-git-send-email-brian.austin@cirrus.com>
	<20100226005349.GA3800@opensource.wolfsonmicro.com>
	<C8CA3F5B-3BB3-497C-98AC-EAC10536BD93@cirrus.com>
	<20100226101259.GA18053@rakim.wolfsonmicro.main>
Reply-To: brian.austin@cirrus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B5DC7103A19
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 17:53:48 +0100 (CET)
In-Reply-To: <20100226101259.GA18053@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, heelrod@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-26 at 10:12 +0000, Mark Brown wrote:
> On Thu, Feb 25, 2010 at 07:59:29PM -0600, Austin, Brian wrote:
> 
> > Thanks alot for the feedback, I'll start fixing it up tomorrow.
> > Should I send the smdk2443 driver, or wait till this is fixed up?
> 
> May as well send it, there should be relatively little coupling to the
> CODEC driver.  Is this a plugin module for the SMDK or does it need
> flying wires or mods to get it hooked up?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

It requires wiring onto the I2C Connector and Dropping lines on the I2S
as well.

The device is wired correctly, just haven't gotten it to work with the
newer kernels.
