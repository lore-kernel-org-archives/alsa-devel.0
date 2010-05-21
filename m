From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Fri, 21 May 2010 08:35:31 +0200
Message-ID: <4BF629B3.9020904@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>	<AANLkTilKqn_X3FUdDmCqy3YKdYeT47oIGGaqUitzruDk@mail.gmail.com>	<201005201141.28755.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F1A02246E7
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 08:35:42 +0200 (CEST)
In-Reply-To: <AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org, "Sebastian H." <vand2@gmx.de>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I believe it could be extended to support a continuous range.
> For example, some hardware uses a 32bit value to control the gain.
> The mix operation is simply "the_sample" * "the_control_value".
> So in this case the hardware has a linear control that can be
> considered continuous for our purposes.

Such controls already exist:

$ grep -rl DB_LINEAR sound/
sound/i2c/other/ak4xxx-adda.c
sound/pci/oxygen/hifier.c
sound/pci/oxygen/oxygen.c
sound/pci/ymfpci/ymfpci_main.c
sound/soc/codecs/stac9766.c
sound/soc/codecs/wm8350.c
sound/soc/codecs/wm8400.c
sound/soc/codecs/wm8990.c

> The conversion from the control value to a usable value would have to
> include a user land log operation.
> It was never implemented due to lack of demand.

It is implemented.

> For the cards that do have this 32bit linear value, a simple lookup
> table is used in the kernel code to convert it to 256 step values.

Which driver is this?  It should be changed to use the full range.


Regards,
Clemens
