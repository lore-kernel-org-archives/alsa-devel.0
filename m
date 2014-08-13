From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to	firewire-speakers
Date: Wed, 13 Aug 2014 09:06:06 +0200
Message-ID: <53EB0E5E.40004@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <53E795BD.1070100@ladisch.de> <53E957EA.3030601@sakamocchi.jp>
 <53E9BDC2.3000801@ladisch.de> <53EA9901.40306@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3E25D2654E9
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 09:06:07 +0200 (CEST)
In-Reply-To: <53EA9901.40306@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Aug 12 2014 16:09, Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> On Aug 11 2014 00:54, Clemens Ladisch wrote:
>>>> The old driver configured nothing but the rate.  Is there any mechanism
>>>> to set the stream format?
>>>
>>> Yes. It's AV/C stream format information command.
>>> [...]
>>> But in this series of patches, I don't use this command. I expected the
>>> models to change stream format according to parameters in AMDTP packets
>>> such like the value of dbs field.
>>
>> Apparently, the firmware doesn't support automatic format detection
>> completely, and requires this command for the 2ch 32/44.1 kHz modes.
>
> Apparently and completely, why? Please tell show reasons to judge about
> a lack of automatic format detection. When you developed and committed
> firewire-speakers driver, you confirmed all of combination for PCM
> rate/channels, didn't you?

When I wrote the driver, Jay tested which combinations did actually
work (without any stream format information command; I don't have the
spec), so that's what the driver ended up supporting:
 - 6ch at 32/44.1/48/96 kHz
 - 2ch at 48/96 kHz

If snd-oxfw also does not send the stream format information command,
then I guess that 2ch at 32/44.1 kHz will not work either.

> [...]
> Instead, we should consider the 2ch modes. This mode seems to be used
> for Dolby Pro Logic II and Dolby Digital but I don't know about the
> specification of Dolby something. If we drop these modes, the work to
> develop OXFW driver becomes simpler.

The driver does not need care about the format itself; the data is just
sent as 16-bit words that pretend to be samples.  All the driver has to
do is to handle the "non-audio" bit in the "IEC958 Playback Default" or
"IEC958 Playback PCM Stream" mixer controls; this can be added later.


Regards,
Clemens
