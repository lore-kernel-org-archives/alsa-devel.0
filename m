From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: how to enumerate useful ALSA devices?
Date: Fri, 06 Jan 2012 02:36:56 +0200
Message-ID: <4F064228.9040300@iki.fi>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
	<4F04BAF8.6010701@iki.fi> <4F04C1CA.7070000@iki.fi>
	<CAN8ccibZTviHienALPBhzLT+a5Tmy+J60-Ds_3c0LmtKtfG2mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E8AB10384A
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 01:37:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sypressi.dnainternet.net (Postfix) with ESMTP id 462E52621D4
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 02:30:02 +0200 (EET)
Received: from sypressi.dnainternet.net ([83.102.40.135])
	by localhost (sypressi.dnainternet.net [127.0.0.1]) (DNA Postiturva,
	port 10041)
	with ESMTP id lx0qjjq+f5km for <alsa-devel@alsa-project.org>;
	Fri,  6 Jan 2012 02:30:01 +0200 (EET)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net
	[83.102.40.212])
	by sypressi.dnainternet.net (Postfix) with ESMTP id 9746F2621D0
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 02:30:01 +0200 (EET)
Received: from mail.onse.fi (host-109-204-132-101.tp-fne.tampereenpuhelin.net
	[109.204.132.101])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 447DC2BAD5
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 02:36:57 +0200 (EET)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id F35AB408C5
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 02:36:56 +0200 (EET)
In-Reply-To: <CAN8ccibZTviHienALPBhzLT+a5Tmy+J60-Ds_3c0LmtKtfG2mA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06.01.2012 01:06, Raymond Yau wrote:
> 2012/1/5, Anssi Hannula <anssi.hannula@iki.fi>:
>> On 04.01.2012 22:47, Anssi Hannula wrote:
>>> On 04.01.2012 21:49, Andrew Eikum wrote:
>>
>>>> So I'm really stuck here. Where am I supposed to get a list of devices
>>>> that I can present to the user, including their Bluetooth devices and
>>>> virtual devices from asound.conf?
>>>
>>> I guess the preferred one is 'snd_device_name_hint()', but I don't
>>> really know if the caller is supposed to then handle surroundXX stuff
>>> themself.
>>
>> Reading your last reply made me realize that I forgot that when
>> pulseaudio is not configured, there is also the "default:CARD=foo"
>> device listed (which you noticed), so I guess one could just ignore
>> entries beginning with "front:" or "surround(40|41|50|51|71):", since
>> one can just use "default" instead of them.
>>
> 
> No , this won't work for emu10k1 and ca0106
> 
> snd-emu10k1 require "front", "surround40","surround51" and
> "surround71"  which use "multi" plugin of "front" , "rear" , "clfe" or
> "side" devices
> 
> you can play stereo stream to "rear" device

Ah, thanks for the correction.

-- 
Anssi Hannula
