From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to enumerate useful ALSA devices?
Date: Fri, 6 Jan 2012 07:06:45 +0800
Message-ID: <CAN8ccibZTviHienALPBhzLT+a5Tmy+J60-Ds_3c0LmtKtfG2mA@mail.gmail.com>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
	<4F04BAF8.6010701@iki.fi> <4F04C1CA.7070000@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 5E42B244BE
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 00:06:56 +0100 (CET)
Received: by werb12 with SMTP id b12so859873wer.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2012 15:06:55 -0800 (PST)
In-Reply-To: <4F04C1CA.7070000@iki.fi>
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

2012/1/5, Anssi Hannula <anssi.hannula@iki.fi>:
> On 04.01.2012 22:47, Anssi Hannula wrote:
>> On 04.01.2012 21:49, Andrew Eikum wrote:
>
>>> So I'm really stuck here. Where am I supposed to get a list of devices
>>> that I can present to the user, including their Bluetooth devices and
>>> virtual devices from asound.conf?
>>
>> I guess the preferred one is 'snd_device_name_hint()', but I don't
>> really know if the caller is supposed to then handle surroundXX stuff
>> themself.
>
> Reading your last reply made me realize that I forgot that when
> pulseaudio is not configured, there is also the "default:CARD=foo"
> device listed (which you noticed), so I guess one could just ignore
> entries beginning with "front:" or "surround(40|41|50|51|71):", since
> one can just use "default" instead of them.
>

No , this won't work for emu10k1 and ca0106

snd-emu10k1 require "front", "surround40","surround51" and
"surround71"  which use "multi" plugin of "front" , "rear" , "clfe" or
"side" devices

you can play stereo stream to "rear" device
