From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to	firewire-speakers
Date: Wed, 13 Aug 2014 07:45:21 +0900
Message-ID: <53EA9901.40306@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <53E795BD.1070100@ladisch.de> <53E957EA.3030601@sakamocchi.jp>
 <53E9BDC2.3000801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D5807265357
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 00:45:29 +0200 (CEST)
In-Reply-To: <53E9BDC2.3000801@ladisch.de>
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


On Aug 12 2014 16:09, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On Aug 11 2014 00:54, Clemens Ladisch wrote:
>>> The old driver configured nothing but the rate.  Is there any mechanism
>>> to set the stream format?
>>
>> Yes. It's AV/C stream format information command.
>> [...]
>> But in this series of patches, I don't use this command. I expected the
>> models to change stream format according to parameters in AMDTP packets
>> such like the value of dbs field.
> 
> Apparently, the firmware doesn't support automatic format detection
> completely, and requires this command for the 2ch 32/44.1 kHz modes.

Apparently and completely, why? Please tell show reasons to judge about
a lack of automatic format detection. When you developed and committed
firewire-speakers driver, you confirmed all of combination for PCM
rate/channels, didn't you?

> (That 2ch at 96 kHz actually works is even more curious.  There already
> is that bug regarding listing the seventh format; it's possible that
> they completely forgot to report an eighth format.)

According to Griffin's manual for FireWave, 2ch/96kHz is not supported.
http://griffintechnology.com/support/firewave

> 32kHz, 44.1kHz, 48kHz and 96kHz playback in MBLA mode (non-Dolby)
> 32kHz, 44.1kHz, 48kHz in Dolby Pro Logic II
> 48kHz Encoded Digital in Dolby Digital

So it's natural that there is not the eight format. I think we're not
need to consider 2ch/96kHz mode.

Instead, we should consider the 2ch modes. This mode seems to be used
for Dolby Pro Logic II and Dolby Digital but I don't know about the
specification of Dolby something. If we drop these modes, the work to
develop OXFW driver becomes simpler.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
