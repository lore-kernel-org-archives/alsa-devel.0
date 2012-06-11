From: Selma Bensaid <selma.bensaid@intel.com>
Subject: Re: [PATCH] ASOC: utils: Update dummy codec DAI
 settings to allow stream creation
Date: Mon, 11 Jun 2012 09:39:59 +0200
Message-ID: <4FD5A0CF.4040606@intel.com>
References: <1339058158.1927.15.camel@vkoul-udesk3>
	<1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
	<20120607213057.GA19485@sirena.org.uk> <4FD1B19E.1030808@intel.com>
	<20120611031331.GG28211@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C7FE10415D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 09:40:03 +0200 (CEST)
In-Reply-To: <20120611031331.GG28211@opensource.wolfsonmicro.com>
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
Cc: vinod.koul@intel.com, sylvain.centelles@intel.com, alsa-devel@alsa-project.org, louis.le.gall@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 06/11/2012 05:13 AM, Mark Brown wrote:
> On Fri, Jun 08, 2012 at 10:02:38AM +0200, Selma Bensaid wrote:
>
> Please check your mailer configuration, it's doing something really odd
> with the word wrapping which makes things hard to read.
>
>>> I still don't understand what this is actually supposed to fix - why are
>>> we trying to set up a stream to something that isn't there?  Though it
>>> looks like this was added for dynamic PCM which has no mainline users so
>>> perhaps there's a sensible use for this...
>> I'm trying to use the dummy codec for BT and Modem device where the
>> coded is handled
>> @ AP side.
> You shouldn't be doing this, you should have actual devices for these
> with appropriate capabilities for the device.  Ideally we'd even have
> real drivers for these things!  For example, you're currently setting
> them up as supporting continuous audio rates but both BT and baseband
> devices won't do anything like that.  Even your new version which has
> all the rates enabled has about the same issue.
I can implement my own dummy codec where I do not perform
any actions since in our platform all modem controls and BT controls
are done @AP side. But I really do not understand why ASoC provides the
soc-utils dummy codec? The current version of the dummy codec is
useless since it blocks the stream creation: please refer to soc_new_pcm.

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
