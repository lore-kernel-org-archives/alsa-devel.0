From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Underrun
Date: Tue, 01 Mar 2011 14:42:47 +0100
Message-ID: <4D6CF7D7.2030509@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5665@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E55C01038F0
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 14:41:38 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5665@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "bahathir@gmail.com" <bahathir@gmail.com>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> I am getting many under-run in my audio capture and playback application.
> 
> 1) My CAPTURE buffer is of 1024 * 8 (Period size * no of periods), PLAYBACK buffer is of (512 * 16)
> 2) I try to read 8 K frames each time and write returned frames to playback device.

If you wait until the capture buffer is full, it's likely that you
get over/underruns at this moment.  You have to do the processing in
smaller chunks.

Typically, in loops like this, the normal state is that the capture
buffer is almost empty, and the playback buffer almost full.  You read
one period from the capture buffer (waiting for it if necessary),
process it, and write it to the playback buffer.  You need at least two
period per buffer so that one can be captured/played while the other one
is being processed, and maybe more periods as safety against delays.

> B) Can i use snd_pcm_prepare() twice in two consecutive lines

Yes (if the driver isn't buggy).

Regards,
Clemens


> SASKEN BUSINESS DISCLAIMER: ...

EVEN MORE IMPORTANT DISCLAIMER:
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.
