From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ASoC: kirkwood: change the compatible
 string of the kirkwood-i2s driver
Date: Thu, 5 Sep 2013 19:03:41 +0200
Message-ID: <20130905190341.4a4a7820@skate>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130905185456.175f556b@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id A53F6261A1F
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2013 19:03:43 +0200 (CEST)
In-Reply-To: <20130905185456.175f556b@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dear Jean-Francois Moine,

On Thu, 5 Sep 2013 18:54:56 +0200, Jean-Francois Moine wrote:

> The name of the kirwood audio driver has been changed from
> "kirkwood-i2s" to "mvebu-audio" by Russell King
> (http://www.spinics.net/lists/arm-kernel/msg264185.html).
> I have just used this name in the DT.

I don't care about the driver name: it can be changed whenever you want.

On the opposite, the DT compatible string becomes part of the kernel
ABI, and therefore cannot be changed once it has been defined. This is
why I worry about this one.

And the compatible string doesn't necessarily need to match the driver
name.

> Then, the second interrupt in Dove is not used in the driver. If it
> should, it would be present in the DTs of the dove boards only, so,
> actually, there is not need to have different compatibles.

Indeed the second interrupt is not used in the driver, but the binding
still specifies that two interrupts have to be mentioned, which is
incorrect for Kirkwood. The fact that on Kirkwood there is one
interrupt, while Dove has two, is an indication that the IP block is
not exactly the same. Should this error interrupt become useful in the
driver, it should be done only for Dove, so it makes sense to have two
different compatible strings.

> Eventually, you are talking about some other mvebu SoCs. Before adding
> any new compatible, it would be nice to know if, for example, some
> changes are needed in the kirkwood/dove audio driver for the Armada 370...

So far, it looks like no changes should be needed. I'm sure this will
bring you to the conclusion that 'mvebu-audio' is a good compatible
string: it is not because while we know what Armada 370 looks today, we
have absolutely no idea what the next Armada <something> will look
like. Maybe it will use the same audio IP block, with just a few little
variations.

Again, please read the mails from Rob Herring and Arnd Bergmann. It has
been said numerous times that using the name of the oldest SoC that has
the compatible IP block was the right choice for the compatible string.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
