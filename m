From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How does usbaudio synchronize on playback?
Date: Fri, 14 Nov 2008 09:33:45 +0100
Message-ID: <491D37E9.9070901@ladisch.de>
References: <0MKp8S-1L0ep82OqE-0006QQ@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B903124422
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 09:33:33 +0100 (CET)
In-Reply-To: <0MKp8S-1L0ep82OqE-0006QQ@mrelay.perfora.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Crowley <jcrowley@screenpc.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Crowley wrote:
> [...]
> What I don't understand is how does prepare_playback_urb ensure that more
> playback data has actually been written into the buffer?

It doesn't; the ALSA framework does.

When the driver calls snd_pcm_period_elapsed(), ALSA calls the .pointer
callback and checks if an underrun has happened.  Underrun detection
works this way because most sound card hardware reads the data out of
the buffer asynchronously.

> The problem is that we are getting erroneous data, and suspect that it is
> caused by this synchronization issue. When the initial no-data URBs are
> completed, the prepare_playback_urb logic copies a lot of data from the
> buffer into new URBs

The initial URBs should complete one by one, not all at once (this is
the only reason why the driver uses these initial URBs in the first
place).

> but apparently no playback data has been written into the buffer yet
> by the application.

This should result in an underrun and the stream being stopped, except
if your application has disabled this behaviour.


Best regards,
Clemens

-- 
> This message and any accompanying attachments contains information from
> ScreenPC,Inc. that is confidential and/or privileged. The information is
> intended to be for the use of the individual or entity named above. If you
> are not the intended recipient, be aware that any disclosure, copying,
> distribution or use of the contents of this information is prohibited. If
> you have received this email in error, please notify the sender immediately
> by reply email and destroy all copies of the original email.

*** DISCLAIMER ***
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this
disclaimer.
*** END OF DISCLAIMER ***
