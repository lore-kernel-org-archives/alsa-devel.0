From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/12] add a mc13783 codec driver
Date: Wed, 25 Nov 2009 10:39:59 +0000
Message-ID: <20091125103959.GB17420@opensource.wolfsonmicro.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
	<20091125074631.GB27548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 518C42415E
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 11:40:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091125074631.GB27548@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 08:46:31AM +0100, Sascha Hauer wrote:

> The problem here is that I don't really understand what arguments I
> should supply to this function and how to parse them to archieve what I
> want.

> The MC13783 Voice Codec always uses a network mode to send data. It has
> a fixed width of four slots.

> PMIC_SSI_NETWORK[2:3] defines the slot for primary transmit/receive
> PMIC_SSI_NETWORK[4:5] defines the secondary transmit timeslot
> PMIC_SSI_NETWORK[6:7] defines the secondary receive timeslot

> The Codec has two channels and it's not primarily desgined to do stereo
> Audio. I want to put the primary channel into the first timeslot and
> the secondary channel into the second timeslot.

What are "primary" and "secondary" here?  If they are broadly unrelated
except for the clocking (which is what this sounds like) then they
probably should be handled as separate DAIs.  For the TDM configuration
you should be forcing a slot count of four slots.  The RX and TX masks
will then allow one bit to be set, specifying which of the slots the
data goes in for each direction.
