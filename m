From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Independent usage of two channels
Date: Thu, 22 Jan 2009 12:42:38 +0100
Message-ID: <49785BAE.6090402@ladisch.de>
References: <187c6cc60901220316i65a1558bm4b7c503db062a01e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AD438103880
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2009 12:42:41 +0100 (CET)
In-Reply-To: <187c6cc60901220316i65a1558bm4b7c503db062a01e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Fedin <sonic.amiga@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Fedin wrote:
> Is it possible to use two channels of a sound card as two independent
> devices for PCM playback?

The sound card is probably not able to handle two independent mono
streams, but it is possible to use alsa-lib's software plugins to
emulate two devices on top of the real one.

Put this into your ~/.asoundrc or into /etc/asound.conf:

pcm_slave.stereo_slave {
	pcm "hw:0"          # or "hw:1" for the second card ...
	channels 2
}

pcm.left {
	type plug
	slave.pcm {
		type dshare
		slave stereo_slave
	}
	bindings [ 0 ]
}

pcm.right {
	type plug
	slave.pcm { type dshare slave stereo_slave }
	bindings [ 1 ]
}

Then use device names "left" and "right" instead of "default".


HTH
Clemens
