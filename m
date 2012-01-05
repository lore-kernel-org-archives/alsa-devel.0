From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: how to enumerate useful ALSA devices?
Date: Thu, 05 Jan 2012 19:26:03 +0200
Message-ID: <4F05DD2B.9080400@iki.fi>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
	<8E4C156DA5797D418DBFADFD8CE655A41782620646@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw-out1.cc.tut.fi (mail-gw-out1.cc.tut.fi [130.230.160.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 9481024502
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 18:26:09 +0100 (CET)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41782620646@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: aeikum@codeweavers.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05.01.2012 11:59, Joerg-Cyril.Hoehle@t-systems.com wrote:
> Andrew Eikum wrote:
>> I tried experimenting with snd_device_name_hint().
>> surround40:CARD=SB,DEV=0
>> surround41:CARD=SB,DEV=0
>> surround50:CARD=SB,DEV=0
>> surround51:CARD=SB,DEV=0
>> surround71:CARD=SB,DEV=0
> I'm not sure Wine should enumerate these.  How can it tell the difference
> so as to announce the correct channel mapping to applications?
> E.g. 41 vs 50, both 5 channels? Ideally, that should be announced as
> one device (as it really is), capable of supporting different formats,
> with one preferred format (perhaps the one with most channels) that GetMixFormat uses.

Yep, as noted I think it should just ignore "surroundXX" and "front" and
only announce the "default" ones (there will be multiple "default" ones
with different $CARD when there are multiple cards, except when
pulseaudio is in use in which case there is only one "default" which
goes to pulseaudio).

IIRC the "surroundXX" and "front" ones are just legacy stuff. Then
again, if that is the case, one'd except them to not have the hint tag
making them listed in "-L"...

> OTOH, I find it important that Wine announces a device capable of more
> than stereo if there's one in the system.


-- 
Anssi Hannula
