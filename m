From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Wed, 09 May 2012 15:01:23 +0300
Message-ID: <4FAA5C93.6020703@ti.com>
References: <1336477945-27460-1-git-send-email-peter.ujfalusi@ti.com>
	<20120508122630.GM15893@opensource.wolfsonmicro.com>
	<4FA914C1.904@ti.com>
	<20120508134123.GQ15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B814104174
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:01:10 +0200 (CEST)
Received: by lbbgo11 with SMTP id go11so159773lbb.31
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2012 05:01:05 -0700 (PDT)
In-Reply-To: <20120508134123.GQ15893@opensource.wolfsonmicro.com>
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, "Cousson,
	Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 05/08/2012 04:41 PM, Mark Brown wrote:
> On Tue, May 08, 2012 at 03:42:41PM +0300, Peter Ujfalusi wrote:
>> On 05/08/2012 03:26 PM, Mark Brown wrote:
> =

>>> Why are we loading MFD components using device tree?  It seems like
>>> we're doing something very wrong if we need people to explicitly write
> =

>> I have based the twl6040 DT structure on the already existing twl4030,
>> twl6030 MFD parts.
> =

> This really isn't relevant to the issue...

I thought it was...

>> Also without a DT entry I will not have a way to use phandle to connect
>> the codec in the machine driver.
> =

> Of course you do!  There's going to be a device tree entry for the chip,
> things can point at this perfectly happily.

That's true but what can I do with that in the ASoC machine driver? The
chip driver is _not_ the codec driver.
I can craft the pdata for the MFD child devices out from the DT
information but then the child devices will have no dev.of_node since
they were not probed via OF.
So I would have not phandle for the codec to be used to define the
dai-link connection within the sound dts section.

Am I missing something here?

-- =

P=E9ter
