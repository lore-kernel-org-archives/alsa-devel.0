From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: unable to do simultaneous playback and recording
Date: Thu, 20 Aug 2009 08:49:19 +0200
Message-ID: <4A8CF1EF.2000204@ladisch.de>
References: <909731.61887.qm@web94704.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 16C64243C7
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 08:49:13 +0200 (CEST)
In-Reply-To: <909731.61887.qm@web94704.mail.in2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: prashant chopade <prashantchopade@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

prashant chopade wrote:
> As per discussion, I know that ALSA driver does not have support for
> simultaneous playback and recording.

ALSA _does_ support full duplex, if the hardware and driver support it.

> We are using AD1981B codec, so our hardware has a support for
> simultaneous playback and recording of an audio.

It looks as if your AC'97 controller driver is buggy.


Best regards,
Clemens
