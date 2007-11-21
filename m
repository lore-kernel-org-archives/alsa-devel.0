From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Broken playback
Date: Wed, 21 Nov 2007 16:28:27 +0100
Message-ID: <1195658907.11141.1222567701@webmail.messagingengine.com>
References: <BLU107-W438E9F5D7EFEF18ED543BDC1780@phx.gbl>
	<1195644962.10939.1222529331@webmail.messagingengine.com>
	<BLU107-W5983EEB0D75DFABAC2EC60C1780@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CAB0E24C56
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 16:28:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <BLU107-W5983EEB0D75DFABAC2EC60C1780@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gabriele Melia <gabmelia84@msn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gabriele Melia wrote:
> i have already tried to read and decode some data in order to accumulate
> 1 second of data to prevent broken audio,
> but nothing change, analysing the issue i have found that broken audio
> comes when the snd_pcm_writei is called with a size that is 5000. So it
> takes time to dispach all this size.

Try non-blocking mode (see the snd_pcm_nonblock function).  In non-
blocking mode, the writei call will only write as much data as can be
written without waiting (or returns -EAGAIN if the buffer is already
full at the moment).


HTH
Clemens
