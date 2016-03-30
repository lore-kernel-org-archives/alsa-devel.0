From: Daniel Wagner <wagi@hotel311.server4you.de>
Subject: Re: [FFADO-devel] [RFC][PATCH] ALSA: firewire-lib:
 support Linux tracing to dump a part of packet data
Date: Wed, 30 Mar 2016 20:49:43 +0200
Message-ID: <56FC1FC7.4040600@hotel311.server4you.de>
References: <1459081086-6145-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hotel311.server4you.de (hotel311.server4you.de [85.25.146.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A58BA2612CC
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 20:49:54 +0200 (CEST)
In-Reply-To: <1459081086-6145-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 27.03.2016 14:18, Takashi Sakamoto wrote:
>  	/*
>  	 * This module supports 'Two-quadlet CIP header with SYT field'.
>  	 * For convenience, also check FMT field is AM824 or not.
> @@ -523,7 +534,11 @@ static int handle_in_packet(struct amdtp_stream *s,
>  		dev_err(&s->unit->device,
>  			"Detect discontinuity of CIP: %02X %02X\n",
>  			s->data_block_counter, data_block_counter);
> -		return -EIO;
> +		if (!trace_in_packet_enabled())
> +			return -EIO;
> +
> +		/* To identifying this situation. */
> +		trace_in_packet(0xffffffff, 0xffffffff, 999, 99);
>  	}

This looks wrong. Tracing should not change the path taken.

cheers,
daniel
