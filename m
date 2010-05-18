From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creating a /dev entry.
Date: Tue, 18 May 2010 16:07:01 +0200
Message-ID: <4BF29F05.9050701@ladisch.de>
References: <AANLkTiljJRpLd4koKAuELpbJc8GgiDj4_9kHlnX3eScu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 925A010387D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 16:07:55 +0200 (CEST)
In-Reply-To: <AANLkTiljJRpLd4koKAuELpbJc8GgiDj4_9kHlnX3eScu@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adish Kuvelker <adkuvi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adish Kuvelker wrote:
> I am writing a ALSA driver for the AtlasIII AC'97 Controller. The
> controller communicates with the AC'97 Codec and the necessary PCM,
> Sequencer, Control and Timer nodes are created in the /sys. Also I get
> the necessary information registered in the procfs under /proc/asound.
> However, I do not see any sound nodes created under /dev. Are these
> nodes created by the sound driver registration function which creates
> necessary files under /sys

Yes, if the udev daemon is running.

> Although I am using kernel 2.6.19.2, it doesn't have the "udev"
> enabled.

Then you have to use the snddevices script.


Regards,
Clemens
