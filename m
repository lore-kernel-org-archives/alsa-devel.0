From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_wait function
Date: Sat, 10 Nov 2012 18:20:12 +0100
Message-ID: <509E8CCC.5040003@ladisch.de>
References: <509E8445.8050001@tele2.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 27E2126160F
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 18:20:24 +0100 (CET)
In-Reply-To: <509E8445.8050001@tele2.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Enno Fennema <ennofennema@tele2.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Enno Fennema wrote:
> The documentation says this functions waits for the pcm to become ready for I/O.
> I am not sure what ready means in this context.

Ready for playback/capture, i.e., some frames are available.

> Is there a function to wait for entering the SETUP state. In particular I would
> like to wait for pcm_snd_drain to finish.

This is not possible.  alsa-lib is not thread-safe, so while another thread is
executing snd_pcm_drain, you cannot access the same PCM device.
Let the other thread send a message after snd_pcm_drain has finished.


Regards,
Clemens
