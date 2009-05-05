From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help-Pause/Resume API
Date: Tue, 05 May 2009 13:08:00 +0200
Message-ID: <4A001E10.9080607@ladisch.de>
References: <9D5E1752379A43408015F7FE98466115023F03CA@CHNEXVS01.VSNLXCHANGE.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 36FD724525
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 13:07:55 +0200 (CEST)
In-Reply-To: <9D5E1752379A43408015F7FE98466115023F03CA@CHNEXVS01.VSNLXCHANGE.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sudeept Prusti <sudeeptp@tataelxsi.co.in>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sudeept Prusti wrote:
> Can anyone educate me which alsa-lib API used for pause and resume.
> I have a minimal alsa code for pcm playback and i need the needed API
> for test pause and resume feature on pcm playback.

First, to check whether the device supports pausing, one should call
snd_pcm_hw_params_can_pause() after calling snd_pcm_hw_params().
However, in your case, you already know this for your device.

To pause or resume a stream, call snd_pcm_pause(pcm, 1) or ...0).


HTH
Clemens

> The information contained in this electronic message and any attachments to this message are intended for the exclusive 
> use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended
> recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy
> all copies of this message and any attachments contained in it.

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
