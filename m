From: Daniel Svensson <nano@nittionio.nu>
Subject: Re: snd-emu10k1x samplerate capabilities
Date: Wed, 29 Dec 2004 13:49:21 +0100
Message-ID: <0F97F0E8-5998-11D9-9928-000D93353726@nittionio.nu>
References: <1104180478.4396.5.camel@paranoia> <s5hekh9jo4i.wl@alsa2.suse.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekh9jo4i.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 2004-12-29, at 13.16, Takashi Iwai wrote:

> At Mon, 27 Dec 2004 20:47:58 +0000,
> Daniel Svensson wrote:
>>
>> The snd-emu10k1x driver accepts samplerates that the hardware is not
>> capable of handling.
>>
>> rate = 44100;
>> err = snd_pcm_hw_params_set_rate_near (pcm, hwparams, &rate, NULL);
>>
>> err should be less than zero if the requested rate is 44100, or the 
>> rate
>> should be set to 48000. As it's handled now when that line is executed
>> the samplerate is set to 44100 and sound is broken.
>
> I still don't find out the bug in emu10k1x.c.
> Which version?  Which PCM name did you use?
  Well, I used latest from CVS the 29:th of december. This problem 
existed 6 months ago but of some reason I didn't repport it then.
I'm not very familiar with alsas huge codebase so I haven't had a look 
at it.

-- Daniel Svensson



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
