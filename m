From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: When command SNDRV_PCM_TRIGGER_STOP is asked in
 snd_pcm_ops trigger(),
 which buffer in the buffer list should be the last one to output by the DMA?
Date: Fri, 09 Nov 2007 09:58:34 +0100
Message-ID: <1194598714.2943.1220397765@webmail.messagingengine.com>
References: <4e5ebad50711072143t230c737fv7af600fe172ccd34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id EAD1C247BD
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 09:58:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4e5ebad50711072143t230c737fv7af600fe172ccd34@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sonic Zhang <sonic.adi@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sonic Zhang wrote:
> After ALSA starts playing, several buffers ahead of current one
> running by the DMA controller are usually filled in advance by the
> ALSA layer. When command SNDRV_PCM_TRIGGER_STOP is asked in
> snd_pcm_ops trigger(), which buffer should be the last one to output
> by the DMA?

When the stop trigger is called, the stream should be stopped
immediately, that is, you should, if possible, not even wait for the end
of the current buffer.

When an application calls snd_pcm_drain(), ALSA stops filling the buffer
and waits until the data has played before calling the stop trigger.


HTH
Clemens
