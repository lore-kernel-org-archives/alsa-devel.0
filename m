From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 26/29] ALSA: oxfw: Add support AMDTP
	in-stream
Date: Sun, 16 Nov 2014 22:21:08 +0100
Message-ID: <54691544.2020501@ladisch.de>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6BEAB2612CC
 for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2014 22:21:25 +0100 (CET)
In-Reply-To: <1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> +++ b/sound/firewire/oxfw/oxfw-stream.c
> +int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
> +				  struct amdtp_stream *stream,
> +				  unsigned int rate, unsigned int pcm_channels)
> +{
> ...
> +	if (atomic_read(substreams) == 0)
> +		goto end;
> +
>  	mutex_lock(&oxfw->mutex);

What happens if hw_free is called between the calls to atomic_read() and
mutex_lock()?

And why are the substreams counters atomic?
Can't they just be normal variables accessed from inside the mutex?


Regards,
Clemens
