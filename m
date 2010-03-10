From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/20] ASoC: S3C: I2Sv2: Remove
 S3C_IIS_V2_SUPPORTED define
Date: Wed, 10 Mar 2010 12:51:34 +0000
Message-ID: <20100310125133.GR24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<20100310104913.GF24422@rakim.wolfsonmicro.main>
	<1b68c6791003100438m220c15eid0206b4b36188f5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48B9B1038B8
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:51:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100438m220c15eid0206b4b36188f5f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 09:38:16PM +0900, jassi brar wrote:

> The way I see it, if we keep it we will have to add every supported
> SoC to the list

I agree that the current situation sucks.  Like I say, I suspect that we
can handle this better with platform data if we knew what the
underlying changes in the blocks are but right now this is all being
reverse engineered from the datasheets which don't explicitly mention
any differences or similarities between the IIS controllers of the
various CPUs that people happen to have been able to obtain datasheets
for - you're in a much better position to be able to do something about
this than most since you have access to Samsung internal information.

What I'm saying here is that while the driver needs to have per
processor ifdefs I'd rather keep the matching plain text #error - if we
can get those removed then this block could also go but it should happen
in that order.

> which is kinda redundant since that information could already be extracted from
> Makefile. The list of supported SoC could be useful if we somehow knew
> the future SoCs' characteristics to tell if they wud work or not, but
> the developer
> has to first check the Manual and see if the s3c-i2s-v2.c could be
> made use of or not.
> Besides, I assume 'user' to be the MACHINE driver writer and 'developer' to be
> the CPU driver writer.

Thing is that people writing machine drivers will frequently try
building the driver if they're working on a SoC that isn't supported yet
- they'll see a generic Samsung IIS controller driver and so (reasonably
enough) try to use it.  The error message is there to try to make it
clearer to them that they either need to turn into a CPU driver
developer and make sure support is OK or get someone else to do the
required work.
