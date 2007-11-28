From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: mbox II
Date: Wed, 28 Nov 2007 10:30:43 +0100
Message-ID: <1196242243.6990.1223644427@webmail.messagingengine.com>
References: <20071126152742.9A9FE3227E9@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C448F24B0F
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 10:30:43 +0100 (CET)
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 32E6257C8C
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 04:30:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071126152742.9A9FE3227E9@smtp7-g19.free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

rmgls@free.fr wrote:
> > try plughw
> 
> i tried:
> aplay plughw:0 (plughw:0,0) (plughw:0,1) (plughw:0,2) coq.wav
> 
> this time no coredump, aplay try to play, but no sound on the monitoring
> of the mbox II, a complete silence.
> 
> - perhaps the mixer is muted!
> 
> i cannot adjust the mixer:
> amiser
> no elements found.

Some USB devices don't have a software-controllable mixer.

Please show the output of "lsusb -v" for this device.

> otherwise, is a wrapper to the win driver suitable, or even possible?

Probably not.


Regards,
Clemens
