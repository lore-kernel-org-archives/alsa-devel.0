From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Support for hardware amplifier
Date: Mon, 13 Mar 2017 14:12:24 +0100
Message-ID: <96eb395b-820c-822b-e302-f087715c1a69@metafoo.de>
References: <trinity-3cd7c391-e04b-46d6-acf6-9f79662cab0d-1489408763815@3capp-gmx-bs77>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D2D5266BDA
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 14:12:26 +0100 (CET)
In-Reply-To: <trinity-3cd7c391-e04b-46d6-acf6-9f79662cab0d-1489408763815@3capp-gmx-bs77>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felix Bruns <abaoaqu@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/13/2017 01:39 PM, Felix Bruns wrote:
> Hi,
> 
> I am working on embedded device (using an i.MX6  MCU) which has an external amplifier.
> 
> Unfortunately I could not find much information if and how the gain of hardware amplifiers are controlled by alsa.
> (The only example for hardware amplification I found is the arcam-av plugin...)
> 
> Is creating a plugin the recommended way of supporting (external) hardware amplification in alsa?
> Can somebody clarify or point me to another example?

Usually the amplifier is integrated in the overall sound card that is
presented to userspace. No special plugins needed. The recommended way for
implementing this is to use ASoC since ASoC allows to easily assemble a
sound card from multiple components.

The amplifier is implemented as a standalone driver and there is a so called
machine driver that puts all the different components together.

For examples of amplifier drivers see the "Amps" section in
sound/soc/codecs/Makefile. For an example of a machine driver that uses an
external amplifier have a look at sound/soc/omap/rx51.c.

- Lars
