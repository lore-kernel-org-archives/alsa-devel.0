From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How do I tell ALSA that my driver supports every
 possible sample rate?
Date: Mon, 23 Jul 2007 19:14:27 +0200
Message-ID: <1185210867.7590.1201603759@webmail.messagingengine.com>
References: <46A4CF38.3050107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EA57010385A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 19:14:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46A4CF38.3050107@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I'm building an ASOC driver, and I want to tell ALSA that my PCM and my I2S drivers 
> support every possible sample rate, because it's the codec that determines the real 
> limitations.  What SNDRV_PCM_RATE_xxx bit-pattern do I specify that will
> always match?

To indicate that the PCM device supports all sample rates between the
minimum and the maximum, set SNDRV_PCM_RATE_CONTINUOUS in addition to
the other supported bits.

However, in your case these bits should be set according to the
capabilities of the codec.


HTH
Clemens
