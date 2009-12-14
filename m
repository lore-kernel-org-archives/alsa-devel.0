From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: DMA and delay feedback
Date: Mon, 14 Dec 2009 14:02:54 +0000
Message-ID: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FA20245B1
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 15:02:58 +0100 (CET)
Received: by fxm3 with SMTP id 3so3438976fxm.4
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 06:02:57 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Would there be benefit in separating the DMA and the transfer of audio
samples to the sound card hardware from the delay and hw position
feedback.
For example, If the playback position is 0, the hardware has probably
already transferred one period of the sound card.
So, one cannot write to playback position 2 and expect it to be output
to the sound card if the period size is 1024.

For transfer purposes, one only needs to know that DMA transfer is
complete on period X so that period X can now be over-written.
I believe that this is what the DMA interrupt indicates. One needs to
reliably detect a missed interrupt.
It one took this approach, one might be able to hide the "missed
interrupt" problem.
When the interrupt finally did arrive, we would know where the next
free period X is, and continue writing samples to that, irrespective
of what went wrong before.
This would allow for auto-recovery of the audio stream without having
to stop and start the ring buffers again.

One then needs to determine how one can get accurate "delay" values
back from all sound card types.
The "delay" value is used for applications like ensuring that audio
and video play in sync.
The problem ones at the moment appear to be the intel8x0 and hd-audio ones.
There may be benefits from making the "delay" value return in
nanoseconds instead of samples, particularly if gettimeofdate() is
being used to try to produce accurate "delay" values.

Kind Regards

James
