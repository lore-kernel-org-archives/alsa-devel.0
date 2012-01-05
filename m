From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to enumerate useful ALSA devices?
Date: Thu, 5 Jan 2012 13:35:06 +0800
Message-ID: <CAN8cciaiJKFCQrcaW2zLcgZ9fwwY-HkGmLd=2XPZ=n=PomKu7A@mail.gmail.com>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
	<4F04BAF8.6010701@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 163031038AD
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 06:35:09 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so113915wib.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Jan 2012 21:35:07 -0800 (PST)
In-Reply-To: <4F04BAF8.6010701@iki.fi>
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
> Hi,
>
> I'm not really an expert on ALSA api (having never actually used it),
> but I'll try to clarify what I can. I hope someone will correct me if
> I'm wrong on some point.
>
> On 04.01.2012 21:49, Andrew Eikum wrote:
>>> The 2008 audio guide recommends
>>> http://0pointer.de/blog/projects/guide-to-sound-apis.html
>>> "Do not use the snd_card_xxx() APIs. For enumerating use
>>>  snd_device_name_hint() (and related functions).
>>>  snd_card_xxx() is obsolete... Bluetooth audio are not included"
>>>
>>> Is that correct advice?
>>>
>>> Wine still uses snd_card, so it knows only about "default" and
>>> "plughw:x,y".  I believe that's wrong but don't know what should be
>>> used instead in order not to come up with a long list of artificial
>>> names mentioned in /usr/share/alsa/alsa.conf such as surround51 when
>>> the poor on-board card knows nothing but 16 bit stereo.
>>>
>>> I'm looking for a list of working devices on this machine, which likely
>>> should contain "default" (usually leading to PA on a recent Ubuntu
>>> machine),
>>> "plug:dmix" (PA getting out of the way when trying to use other devices),
>>> "hw:0,0" and presumably not much more.
>
> Probably not "hw:0,0", though, as AFAIK one should prefer the symbolical
> names instead (e.g. those in "aplay -L").

AFAIK PA server only use one sink and one source

so if you have two or more sound cards , you still can open hw device
of your second sound card which is not used by PA server.


>
>> Bump, still hoping for an answer to this.
>>
>> I tried experimenting with snd_device_name_hint(). It gave me what
>> looked like a promising list, consisting of:
>>
>> null
>> front:CARD=SB,DEV=0
>> surround40:CARD=SB,DEV=0
>> surround41:CARD=SB,DEV=0
>> surround50:CARD=SB,DEV=0
>> surround51:CARD=SB,DEV=0
>> surround71:CARD=SB,DEV=0
>> iec958:CARD=SB,DEV=0
>>
>> This is identical to the list from "aplay -L".

The hint just mean that surround71 may be supported and
you get the above list even when your HDA codec support stereo only

so you still have to check whether pcm device support multi-channels
like PA server

>>
>> But, passing these to aplay fails if I have PulseAudio running
>> ("device in use").
>
> Correct. You need to use pulse directly or the default/pulse device
> which passes audio to pulseaudio.
>
>> If I kill PA, then they don't fail, but give
>> warnings about rate conversion and suggest the plug plugin. So I stick
>> "plug:" in front of the device name, and they fail again ("unknown
>> parameter front:CARD"). Clearly I'm doing something very wrong. But I
>> don't know what!

Try aplay -D "plug:'front:CARD=SB'" foo.wav


>
> "plug:'surround71:CARD=SB,DEV=0'"
>

The drawback of using "plug:" is you cannot know whether the device
really support multi-channels

the alternative is to find those "Surround Playback Volume",  "Center
Playback Volume" or "Side Playback Volume" controls

>> Then it occurred to me that this list also contains neither "default"
>> nor the "pulse" device in my asound.conf[1]. Both of these work when
>> passed to aplay.
>
> AFAIK this is because that file is missing the "hint" statement for the
> devices, which are present on my system (Mageia), and also in upstream ALSA:
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/50-pulseaudio.conf;h=dd85dab835168bde84d7b8a3be78fb896ece8ea8;hb=HEAD
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/99-pulseaudio-default.conf.example;h=4f5885806898a76f5a5c9b3ec76b804fe54e2480;hb=HEAD
>

The list name hint provide more device names (e.g. dmix, dsnoop,
plughw and hw) if the user change defaults.namehint.extended from
"off" to "on


# show all name hints also for definitions without hint {} section
defaults.namehint.showall off
# show just basic name hints
defaults.namehint.basic on
# show extended name hints
defaults.namehint.extended off


>> Looking to other projects for help, I find that VLC uses the snd_card_
>> functions, just like Wine currently does. Of course, that fails to
>> find the "pulse" device from asound.conf. And mplayer's libao2 uses a
>> couple of hard-coded device names, which is even worse (right?).
>>
>> So I'm really stuck here. Where am I supposed to get a list of devices
>> that I can present to the user, including their Bluetooth devices and
>> virtual devices from asound.conf?
>

> I guess the preferred one is 'snd_device_name_hint()', but I don't
> really know if the caller is supposed to then handle surroundXX stuff
> themself.
>

It sill does not provide "device 2" Independent Headphone for ADI and
VIA codecs
(i.e. Realtek HDA 2nd Output in windows)
