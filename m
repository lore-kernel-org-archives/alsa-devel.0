From: Damien Zammit <damien@zamaudio.com>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Mon, 16 Mar 2015 22:39:01 +1100
Message-ID: <5506C0D5.7000909@zamaudio.com>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id AEE5D260686
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 12:39:12 +0100 (CET)
Received: by pdnc3 with SMTP id c3so56155327pdn.0
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 04:39:11 -0700 (PDT)
In-Reply-To: <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de, robin@gareus.org
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 16/03/15 03:01, Takashi Sakamoto wrote:
> Digi 002/003 family uses own way to multiplex PCM samples into data
> blocks in CIP payload for received stream, thus AMDTP-conformant
> implementation causes noisy sound.
>
> This commit applies double-oh-three algorism, which discovered by Robin
> Gareus and Damien Zammit in 2012.
>
> As long as I tested, this patch still has disorder that:
>  * 1st PCM channel still causes noise in 2nd PCM channel.
>  * At 88.2/96.0kHz, any PCM channels still causes noise in the other PCM
>    channels.

Can you please double check, I dont think snd_dg00x_protocol_write_s32()
is even being called because amdtp.c needs a small change to prevent
overriding the transmit_samples function pointer.

Damien
