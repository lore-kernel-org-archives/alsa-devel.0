From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: utils: Update dummy codec
	DAI	settings to allow stream creation
Date: Mon, 11 Jun 2012 04:13:32 +0100
Message-ID: <20120611031331.GG28211@opensource.wolfsonmicro.com>
References: <1339058158.1927.15.camel@vkoul-udesk3>
	<1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
	<20120607213057.GA19485@sirena.org.uk> <4FD1B19E.1030808@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B821824A96
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 05:13:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FD1B19E.1030808@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Selma Bensaid <selma.bensaid@intel.com>
Cc: vinod.koul@intel.com, sylvain.centelles@intel.com, alsa-devel@alsa-project.org, louis.le.gall@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 08, 2012 at 10:02:38AM +0200, Selma Bensaid wrote:

Please check your mailer configuration, it's doing something really odd
with the word wrapping which makes things hard to read.

>> I still don't understand what this is actually supposed to fix - why are
>> we trying to set up a stream to something that isn't there?  Though it
>> looks like this was added for dynamic PCM which has no mainline users so
>> perhaps there's a sensible use for this...

> I'm trying to use the dummy codec for BT and Modem device where the  
> coded is handled
> @ AP side.

You shouldn't be doing this, you should have actual devices for these
with appropriate capabilities for the device.  Ideally we'd even have
real drivers for these things!  For example, you're currently setting
them up as supporting continuous audio rates but both BT and baseband
devices won't do anything like that.  Even your new version which has
all the rates enabled has about the same issue.
