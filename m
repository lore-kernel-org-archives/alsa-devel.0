From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Driver for audio power amplifier ICs?
Date: Thu, 01 Oct 2015 11:04:02 +0200
Message-ID: <560CF702.4000106@metafoo.de>
References: <999B71E1-5FDB-4EFD-8E69-975C8A09A0C7@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-050.synserver.de (smtp-out-108.synserver.de
 [212.40.185.108])
 by alsa0.perex.cz (Postfix) with ESMTP id C64FC26042B
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 11:04:07 +0200 (CEST)
In-Reply-To: <999B71E1-5FDB-4EFD-8E69-975C8A09A0C7@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/01/2015 10:49 AM, Rick Mann wrote:
> I've been working on this Beaglebone Black custom audio cape. It has a tlv320aic3104 codec (that I'm still trying to get working properly), and connected to its line outs is a tpa3140d2 analog 2x10W power amplifier. This chip has very little in the way of CPU interface, but it does have /shutdown and /fault lines.
> 
> I'm wondering how ALSA becomes aware of that chip, in order to enable it when it enables certain routes in the tlv320aic3104, and to inform application software if the /fault line asserts.
> 
> I don't mind writing a driver, if necessary, I just don't know where such a thing would fit. I also wonder what the device tree entries for the amp might look like.

Hi,

There are a couple of existing amplifier driver like e.g. max9877 or lm4857.
While those two examples have I2C control interface it is no problem to
implement a driver with just a GPIO control interface. Generally the input
and output pins of the amplifier should be modeled as DAPM widgets with a
widget for the amplifier function in between. You can use a callback
function for the amplifier widget to get notified when the amplifier needs
to be enabled and when not and can use this to control the GPIO.

The connections between the CODEC and the amplifier need to be specified in
the board driver.

- Lars
