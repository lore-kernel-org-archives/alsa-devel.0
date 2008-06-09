From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASOC PCM formats
Date: Mon, 09 Jun 2008 09:20:25 +0200
Message-ID: <484CD9B9.8000208@ladisch.de>
References: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2DE0124877
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 09:20:30 +0200 (CEST)
In-Reply-To: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> Why is the AC97 format set to S16 in all of the drivers? The link is
> 20b and my codec takes 20b, how do I get 20b data to the device?

You can only use sample formats that are supported by the AC97
controller.

> I tried using SNDRV_PCM_FORMAT_S20_3BE but all I get is static.

S20_3LE could in theory be used by USB devices.  There is no hardware
that supports S20_3BE.

How did you use this format?  Which driver is this?

> If I use S24 for the format it works but volume is divided by 16.

S24 means that the 24 sample bits are in the least significant bits of
a 32-bit memory word.  24 sample bits in the most significant bits of
a 32-bit memory word would be S32.  (It might be possible that your
driver gets this wrong.)


Regards,
Clemens
