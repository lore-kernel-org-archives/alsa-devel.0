From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to	firewire-speakers
Date: Sun, 10 Aug 2014 17:54:37 +0200
Message-ID: <53E795BD.1070100@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C8A3E2610AA
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 17:55:40 +0200 (CEST)
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> I have an issue for Griffin Firewave.
>
> This device can handle AV/C Stream Format Information command and
> driver can get to know stream formations via the command.
>
> According to these responses, supported formations are:
> Input Stream to device:
> 	Rate	PCM	MIDI
> 	32000	6	0
> 	44100	6	0
> 	48000	6	0
> 	96000	6	0
> 	32000	2	0
> 	44100	2	0
> 	48000	2	0
>
> But current 'firewire-speakers' has PCM constraints below:
>  - 6ch at 32/44.1/48/96 kHz
>  - 2ch at 48/96 kHz
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073562.html
>
> So this OXFW driver may lost a support for 2ch/96.0kHz for FireWave
> and gain 2ch/32.0kHz and 2ch/44.1kHz.
>
> I don't know exactly the reason of these gaps.

The old driver configured nothing but the rate.  Is there any mechanism
to set the stream format?


Regards,
Clemens
