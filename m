From: Timur Tabi <timur@freescale.com>
Subject: Re: How do I tell ALSA that my driver supports every
 possible sample rate?
Date: Mon, 23 Jul 2007 12:27:31 -0500
Message-ID: <46A4E503.50207@freescale.com>
References: <46A4CF38.3050107@freescale.com>
	<1185210867.7590.1201603759@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 08D4D10385A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 19:27:35 +0200 (CEST)
In-Reply-To: <1185210867.7590.1201603759@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> To indicate that the PCM device supports all sample rates between the
> minimum and the maximum, set SNDRV_PCM_RATE_CONTINUOUS in addition to
> the other supported bits.

So I should do this:

	SNDRV_PCM_RATES_5512 | SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_CONTINUOUS

That's not really elegant.

> However, in your case these bits should be set according to the
> capabilities of the codec.

In the codec driver, I do that.  With ASOC, each driver specifies its own capabilities, 
and ASOC is supposed to reconcile them.  My I2S driver is not aware of the codec's 
capabilities.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
