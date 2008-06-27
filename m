From: Jerry Geis <geisj@pagestation.com>
Subject: Re: seg fault with 1.0.17rc2
Date: Fri, 27 Jun 2008 16:48:37 -0400
Message-ID: <48655225.3060503@pagestation.com>
References: <4863AA01.7080900@pagestation.com>	<s5hwskcp4w5.wl%tiwai@suse.de>	<4863BDCC.8010708@pagestation.com>	<s5hskv0p3qw.wl%tiwai@suse.de>	<4863C7E0.4000605@pagestation.com>	<s5hprq4p2dz.wl%tiwai@suse.de>	<4863CADC.8030802@pagestation.com>
	<s5hlk0sp1ot.wl%tiwai@suse.de> <4863F1A7.70403@pagestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com (unknown [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 69059244E6
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jun 2008 22:48:44 +0200 (CEST)
In-Reply-To: <4863F1A7.70403@pagestation.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jerry Geis wrote:
>
>
> Takashi Iwai wrote:
>> At Thu, 26 Jun 2008 12:59:08 -0400,
>> Jerry Geis wrote:
>>   
>>> Takashi Iwai wrote:
>>>
>>>     At Thu, 26 Jun 2008 12:46:24 -0400,
>>>     Jerry Geis wrote:
>>>
>>>         Takashi Iwai wrote:
>>>         
>>>             At Thu, 26 Jun 2008 12:03:24 -0400,
>>>             Jerry Geis wrote:
>>>         
>>>                 Takashi Iwai wrote:
>>>         
>>>                     At Thu, 26 Jun 2008 10:38:57 -0400,
>>>                     Jerry Geis wrote:
>>>         
>>>                         #0  0xb7e892ff in memcpy () from /lib/tls/libc.so.6
>>>                         #1  0xb74e40a9 in snd_pcm_area_copy (dst_area=0xb7125b70, dst_offset=0, 
>>>                         src_area=0x81dc1c0, src_offset=170, samples=0, 
>>>                         format=SND_PCM_FORMAT_S16_LE) at pcm.c:2589
>>>         
>>>                     samples = 0 and...
>>>         
>>>                         #2  0xb74e438d in snd_pcm_areas_copy (dst_areas=0xb7125b7c, 
>>>                         dst_offset=0, src_areas=0x81dc1cc, src_offset=170, channels=1, 
>>>                         frames=122, format=SND_PCM_FORMAT_S16_LE) at pcm.c:2736
>>>         
>>>                     ... here frames = 122.  Something inconsistent around here.
>>>                     snd_pcm_areas_copy() must passe samples=frames when channels=1.
>>>                     Could you check the values via gdb?
>>>         
>>>                     Takashi
>>>         
>>>                 Takashi,
>>>                 
>>>                 I am not sure what your asking me. The output I provided is gdb what else
>>>                 can I check? Really anxious to get this USB sound device playing 
>>>                 consistantly.
>>>         
>>>             Check whether frames still 122 in frame#1, for example.
>>>         
>>>                 Is there a better asound.conf to use?
>>>         
>>>             The strange thing is that the recent config for usb-audio also uses
>>>             dmix/dsnoop.  And you don't get any errors with the system-default
>>>             config?
>>>         
>>>             Takashi
>>>         
>>>         Takashi,
>>>         
>>>         checking frames still 122 in frame #1 is way over my expertise.
>>>         
>>>         With this asound.conf file It plays but choppy audio.
>>>
>>>     And doesn't it work if you don't define anything, just using the
>>>     system default?
>>>     
>>>     The bug must be fixed, of course.  But I still don't see why you have
>>>     to redefine the configuration...
>>>
>>>     Takashi
>>>
>>>         defaults.ctl.card 0
>>>         defaults.pcm.card 0
>>>         
>>>         pcm.card0 {
>>>           type hw
>>>           card 0
>>>         }
>>>         
>>>         pcm.dmixer {
>>>           type dmix
>>>           ipc_key 1025
>>>           slave {
>>>             pcm "hw:0,0"
>>>             period_time 0
>>>             period_size 2048
>>>             buffer_size 32768
>>>             rate 48000
>>>           }
>>>           bindings {
>>>             0 0
>>>             1 1
>>>           }
>>>         }
>>>         pcm.skype {
>>>           type asym
>>>         
>>>           playback.pcm "dmixer"
>>>           capture.pcm "card0"
>>>         }
>>>         
>>>         pcm.!default {
>>>           type plug
>>>           slave.pcm "skype"
>>>         }
>>>         
>>>         Jerry
>>>
>>> No, thats what I am saying, when I remove the /etc/asound.conf file I get seg
>>> faults.
>>> When I run with the above file I get choppy audio but at least 15 times it
>>> played with no fault.
>>> I presume the system-default file is have no asound.conf file.
>>>     
>>
>> OK.  Also make sure that you have no ~/.asoundrc file.
>>
>>   
>>> Now also, I am not just doing aplay, which seems to work everytime and audio
>>> sounds fine.
>>> I am using the console/dsp from asterisks and playing a wave file through that.
>>> Does that help.
>>>     
>>
>> The best is to find a simpler test case, such as arecord, because
>> otherwise your problem cannot be reproduced on other environment
>> easily.
>>
>> Not sure which format and sample rate asterisk is using, but you may
>> adjust parameters for arecord via command line options to fit with
>> asterisk, too.
>>
>>
>> Takashi
>>
>>   
>
> I am not having any luck using arecord and aplay to simulate my problem.
>
> Do you have any further suggestions?
>
> Jerry
As a thought I switched my asterisk interface from using alsa to oss.
The audio is fine now not choppy and no seg faults.

Jerry
