From: =?ISO-8859-1?Q?St=E9phane_BERTHELOT?= <sberthelot@emisfr.com>
Subject: Re: MCP7A HDMI passthrough audio Linux/ALSA
Date: Fri, 03 Jul 2009 20:07:09 +0200
Message-ID: <4A4E48CD.9010802@emisfr.com>
References: <4A4A01CF.9090203@emisfr.com>	<s5hocs598yz.wl%tiwai@suse.de>	<4A4A0D45.7030501@emisfr.com>	<s5hhbxx98d4.wl%tiwai@suse.de>	<4A4A7AB7.6050103@emisfr.com>	<s5hr5x1apu9.wl%tiwai@suse.de>	<4A4B29D7.5070805@emisfr.com>
	<s5hfxdg7mdv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smith2.emisfr.net (smith2.emisfr.net [88.191.81.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 365E3103950
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 20:07:11 +0200 (CEST)
In-Reply-To: <s5hfxdg7mdv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: wni@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a =E9crit :
> At Wed, 01 Jul 2009 11:18:15 +0200,
> St=E9phane BERTHELOT wrote:
>   =

>> Takashi Iwai a =E9crit :
>>
>>     At Tue, 30 Jun 2009 22:51:03 +0200,
>>     Stephane BERTHELOT wrote:
>>
>>     Hm, so apparently your TV doesn't accept non-audio format?
>>     But TV accepted the ac3dec output with -R option, right?
>>     (Make sure this -- otherwise ac3dec might have decoded by itself.)
>>     =

>>     Basically, -R means to send the encoded an AC3 stream (packed in the
>>     SPDIF format) without setting non-audio bit.  Whether non-audio bit =
is
>>     1 or 0 is the only difference between -C and -R.  So, if -R really
>>     works but not -C, it means that the non-audio bit must be off no
>>     matter what you send.  Weird.
>>
>> I'm sure the TV only accepted -R and not -C (or -P) with the same ac3 fi=
le.
>> But I'm confused since I was quite sure -R would *decode* ac3 to PCM and=
 then
>> send it in LPCM format.
>>     =

>
> Ah, yes, of course.  That's logical, then, that -R works.
>
> Hm, then it's an issue of receiver side?
> Can Windows send the raw AC3 and TV decodes it properly?
>
>
> Takashi
>
>
>   =

Thanks you Takashi,

After investigating on the Windows side (damn!) I finally found that =

with the latest Nvidia official HDMI audio out drivers I was also =

receiving only stereo PCM.
I'm very angry against Sharp since their TV set outputs AC3 when =

switched on DVB tuner mode, it even offer "digital audio out settings" =

on analog inputs (scart / component /...) but strangely this menu is no =

more available when on an HDMI channel.
I'm very upset about this, since this TV set is about 6 months old seems =

already deprecated.
I'm trying to get someone at Sharp service to make an upgrade to get =

digital audio through HDMI to the optical output but I have little hope =

about this. I still can't figure why they do that, is it a digital =

entertainment system or not ? My old frist-gen dvd player does better ...

Thanks anyway for your help and if you can give me some hints about how =

to convince Sharp to make an upgrade for this I will be welcome. I'm =

pretty sure some other users have had the same kind of problems...

I now need either to buy an USB audio card with SPDIF out (or in/out) or =

an HDMI switch (some have spdif out) or even a real new HD Audio Amp, =

but this is getting more and more expensive ...

Thanks a lot Takashi, and I hope I'll find a 'not so expensive' solution =

for this. (If anyone can give me pointer on cheap USB  or HMDI hardware =

... :) )

Stephane.
