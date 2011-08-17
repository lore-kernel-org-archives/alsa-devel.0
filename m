From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio questions
Date: Wed, 17 Aug 2011 08:29:27 +0200
Message-ID: <4E4B5FC7.7090001@ladisch.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de>
	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
	<4E4A9644.3020507@ladisch.de>
	<000001cc5c38$b07abee0$11703ca0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 0138A1038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 08:29:29 +0200 (CEST)
In-Reply-To: <000001cc5c38$b07abee0$11703ca0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>, 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> Any idea on how this frame number can be read,

With usb_get_current_frame_number().

This is not a technical problem; the problem is that nobody has found
the time to implement this in the audio driver.


Regards,
Clemens
