From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to	firewire-speakers
Date: Thu, 14 Aug 2014 07:55:06 +0900
Message-ID: <53EBECCA.6010908@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <53E795BD.1070100@ladisch.de> <53E957EA.3030601@sakamocchi.jp>
 <53E9BDC2.3000801@ladisch.de> <53EA9901.40306@sakamocchi.jp>
 <53EB0E5E.40004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F8326557D
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 00:55:18 +0200 (CEST)
In-Reply-To: <53EB0E5E.40004@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com
List-Id: alsa-devel@alsa-project.org

On Aug 13 2014 16:06, Clemens Ladisch wrote:
> When I wrote the driver, Jay tested which combinations did actually
> work (without any stream format information command; I don't have the
> spec), so that's what the driver ended up supporting:
>  - 6ch at 32/44.1/48/96 kHz
>  - 2ch at 48/96 kHz
> 
> If snd-oxfw also does not send the stream format information command,
> then I guess that 2ch at 32/44.1 kHz will not work either.

If so, Jey's test included something wrong. I hope someone to test these
combinations again, especially 2ch/96kHz.

>> [...]
>> Instead, we should consider the 2ch modes. This mode seems to be used
>> for Dolby Pro Logic II and Dolby Digital but I don't know about the
>> specification of Dolby something. If we drop these modes, the work to
>> develop OXFW driver becomes simpler.
> 
> The driver does not need care about the format itself; the data is just
> sent as 16-bit words that pretend to be samples.  All the driver has to
> do is to handle the "non-audio" bit in the "IEC958 Playback Default" or
> "IEC958 Playback PCM Stream" mixer controls; this can be added later.

Hm. So the driver just transfers 2ch 16bit words in IEC 60958 compliant
data channels, then the device handles them for surround channels. I
misunderstand that Dolby something is a functionality in driver side.


Regards

Takashi Sakamoto
(In summer vacation)
o-takashi@sakamocchi.jp
