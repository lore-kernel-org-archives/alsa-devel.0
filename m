From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 08/44] firewire-lib: Add support for
 channel mapping
Date: Wed, 02 Apr 2014 22:18:39 +0200
Message-ID: <533C709F.3040109@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-9-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2666E26551E
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 22:18:45 +0200 (CEST)
In-Reply-To: <1395400229-22957-9-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Some devices arrange the position of PCM/MIDI data channel in AMDTP packet.
> This commit allows drivers to set channel mapping.
>
> +++ b/sound/firewire/amdtp.h
>  /*
> + * This module supports maximum 64 PCM channels for one PCM stream
> + * This is for our convinience.

                      convenience


Regards,
Clemens
