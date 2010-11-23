From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Writing a driver for Sound Card
Date: Tue, 23 Nov 2010 15:27:28 +0100
Message-ID: <4CEBCF50.1080108@ladisch.de>
References: <AANLkTins58fB33LiFbNpbgAwKWDBtKs71=9ae3D+i+V4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A49FB103A81
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:25:20 +0100 (CET)
In-Reply-To: <AANLkTins58fB33LiFbNpbgAwKWDBtKs71=9ae3D+i+V4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ramya Desai <ramya.desai@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ramya Desai wrote:
> I have a doubt about the Linux sound driver architecture. I need to
> develop the driver with mixer, player, recorder, MIDI etc. components.
> Do I need to develop these components in single driver OR Do I need to
> develop as a individual component (one driver for one component).

You can do this however you want; ALSA doesn't impose any restriction.

Many drivers choose put the code for different components in separate
source files because the components are actually independent.

When a driver uses other modules, this is usually because that hardware
is common for multiple sound cards (e.g., most MIDI interfaces are
compatible with the Roland MPU-401).

> I looked into the /usr/src/linux-2.6.35/sound directory. I did not
> understand it completely. Is there any driver (sample) which I can go
> through?

The basic driver structure is explained in the documentation; most of
the additional code in drivers handles the quirks of actual hardware
and would not be very helpful for you.  Do you have any specific
questions?

Please tell us more about the architecture of your hardware.


Regards,
Clemens
