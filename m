From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Fri, 08 Oct 2010 16:29:27 +0100
Message-ID: <4CAF38D7.6030901@colin.guthr.ie>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>	<4CAF1FA3.5000402@ladisch.de>	<4CAF2533.1060102@colin.guthr.ie>	<4CAF27B7.9080909@colin.guthr.ie>
	<4CAF2DD1.5050306@ladisch.de> <4CAF37DE.8070205@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 317281038BA
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 17:30:08 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P4Etb-0001Nh-Nl
	for alsa-devel@alsa-project.org; Fri, 08 Oct 2010 17:30:07 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 17:30:07 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 17:30:07 +0200
In-Reply-To: <4CAF37DE.8070205@colin.guthr.ie>
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Colin Guthrie at 08/10/10 16:25 did gyre and gimble:
> 'Twas brillig, and Clemens Ladisch at 08/10/10 15:42 did gyre and gimble:
>> Colin Guthrie wrote:
>>> Hmm, just thinking about this (as I don't know the volume control logic
>>> particularly well in PA), the call snd_mixer_selem_set_playback_dB() is
>>> used with a dir argument of +1.
>>>
>>> From what I understand, this would allow me to say "set the volume to
>>> 50dB" and due to the +1 dir, it should select -46.499999 ( because -46.5
>>> mutes it).
>>>
>>> In this case however, the value of -99999.999dB is ultimately selected
>>> (aka 0).
>>>
>>> I'm wondering if the TLV fix actually affects how
>>> snd_mixer_selem_set_playback_dB() call works with the dir argument.
>>
>> Uh, oh.  snd_tlv_convert_from_dB() ignores the minimum-is-mute flag.
> 
> Ahh good, I analysed that kinda correctly then :D
> 
>> Please try this hack:
>>
>> --- alsa-lib/src/control/tlv.c
>> +++ alsa-lib/src/control/tlv.c
>> @@ -335,6 +335,9 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
>>  			if (xdir > 0)
>>  				v += (max - min) - 1;
>>  			v = v / (max - min) + rangemin;
>> +			if (v == rangemin && xdir > 0 && (tlv[3] & 0x10000) &&
>> +			    db_gain > SND_CTL_TLV_DB_GAIN_MUTE)
>> +				v++;
>>  			*value = v;
>>  		}
>>  		return 0;
> 
> 
> Didn't help sadly, but then looking at the code there it seems a little odd.
> 
> Firstly I tried this (extended) patch - I'm not sure it's needed but
> when the first one didn't work I tried to experiment a bit:
> 
> --- a/src/control/tlv.c
> +++ b/src/control/tlv.c
> @@ -323,15 +323,20 @@ int snd_tlv_convert_from_dB(unsigned int *tlv,
> long rangemin, long rangemax,
>                 int min, max;
>                 min = tlv[2];
>                 max = tlv[3];
> -               if (db_gain <= min)
> +               if (db_gain <= min) {
>                         *value = rangemin;
> -               else if (db_gain >= max)
> +                       if (xdir > 0 && (tlv[3] & 0x10000) && db_gain >
> SND_CTL_TLV_DB_GAIN_MUTE)
> +                               *value = rangemin + 1;
> +               } else if (db_gain >= max)
>                         *value = rangemax;
>                 else {
>                         long v = (db_gain - min) * (rangemax - rangemin);
>                         if (xdir > 0)
>                                 v += (max - min) - 1;
>                         v = v / (max - min) + rangemin;
> +                       if (v == rangemin && xdir > 0 && (tlv[3] &
> 0x10000) &&
> +                           db_gain > SND_CTL_TLV_DB_GAIN_MUTE)
> +                               v++;
>                         *value = v;
>                 }
>                 return 0;
> 
> 
> This also catches the case when I try to set the volume to e.g. -5000
> (-50.00dB) as it is < min (which I presume is still -4650, but actually
> didn't check) then it will be set to rangemin and no further checks are
> done.
> 
> What is odd about this tho', is that the flag for min is mute (0x10000)
> is checked on tlv[3] which is also used here for the "max" value.
> 
> Is the use of position 3 correct (both here and on the kernel side) or
> perhaps the max line needs to be:
> 
>                 max = (tlv[3] & 0xffff);
> 
> instead? Either way it didn't help, but I thought the strangeness with
> the tlv[3] value was worth pointing out.
> 
> Many thanks for debugging this with me :)
> 
> Col
> 
> PS, happy to chat on IRC if you prefer - coling

Ignore this mail... I applied the patch to the wrong tree and it put the
hunks in a different place as the context was a 100% match...

I'll retest with this applied correctly! Sorry :D

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
