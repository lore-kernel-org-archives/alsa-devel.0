From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: XRUN happens too often.
Date: Thu, 10 Apr 2008 08:41:40 +0200
Message-ID: <47FDB6A4.7010704@ladisch.de>
References: <loom.20080408T090019-595@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CE84C243C2
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 08:41:45 +0200 (CEST)
In-Reply-To: <loom.20080408T090019-595@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rong-Jhe <r93922118@ntu.edu.tw>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rong-Jhe wrote:
> buffer size = 9408 frames
>
> A sample in 16-bit, two channels is 4 bytes.
> I allocate a audio data of 9408x4=37632 bytes.
>
> audio_data=malloc(buffer_size*4);
>
> This audio_data buffer will receive audio data from the network.
> If this buffer is full, I use snd_pcm_writei( ) to put the buffer into the pcm.

When this buffer is full, the device buffer is completely empty,
and even the slightest delay will result in an underrun.

Write data to the device buffer immediately when you receive it.


HTH
Clemens
