From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/3] ALSA: firewire-lib: change structure
 member with proper type
Date: Wed, 4 Jan 2017 12:13:59 +0100
Message-ID: <ce9f7680-6b12-ec1f-7d0d-1ef931b73d0a@ladisch.de>
References: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
 <20170103025834.17159-4-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 14253266A31
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 12:14:22 +0100 (CET)
In-Reply-To: <20170103025834.17159-4-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> The 'amdtp_stream' structure is initialized by a call of
> 'amdtp_stream_init()'. Although a parameter of this function is for bit
> flags of packet attributes, its type is enumerator.

This is the correct type to use for an enumeration consisting of bit
flags.  What problem do you see with this?

>  int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
> -		      enum amdtp_stream_direction dir, enum cip_flags flags,
> +		      enum amdtp_stream_direction dir, int flags,
>  		      unsigned int fmt,


Regards,
Clemens
