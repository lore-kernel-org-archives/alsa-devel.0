From: "John O'Donnell" <johnod@covad.net>
Subject: Re: made the jump from 0.9.0rc1 (2.4.29) to 1.0.8	(2.6.11.9)
Date: Tue, 17 May 2005 21:40:51 -0400
Message-ID: <428A9D23.9070509@covad.net>
References: <428836D1.6060603@covad.net> <1116226446.26508.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1116226446.26508.2.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2005-05-16 at 01:59 -0400, John O'Donnell wrote:
> 
>>alsamixer: function snd_ctl_open failed for default: No such file or 
>>directory
>>
> 
> 
> It sounds like the /dev/snd/* entries do not exist.  Your distros
> install scripts should create them.
> 
> Lee

TYVM - that was precisely the problem.  I ran sndconfig and all is well.
But I seem to have to run that every time I boot.  I think Slackware 
10.1+ uses udev if that means anything to anyone.  I havent done 
research yet and it is a minor issue...

compared with the next issue.  And this keeps me back in 2.4/0.9.0rc1.

Weird issue.  Everything else seems to work, World of Warcraft under 
cedega, xine (been watching long movies, etc just fine), xmms works 
great thru my 2nd sound card (onboard VIA) line-linked to my 1st 
(trident) which is how I always listen to MP3s and play Enemy Territory 
(ET uses the sound exclusively and I like to use TeamSpeak at the same 
time).  Teamspeak works great thru the primary card.

I am a Unreal Tournament NUT at heart.  I cant leave this game.  I run a 
dual proc linux server hosted with like 10 UT servers.

The sound in my client STUTTERS?!?!?  I thought maybe it was video as it 
affects the video display too, but I ran ut -nosound and no odd video 
effects, so I believe it is definitely sound driver related.  I thought 
maybe turning off the kernel preemption might help but it has made no 
difference.

UT uses OSS.  I am not sure what all the other software is using.

I have tried both the Generic and OpenAL subsystems and BOTH stutter and 
crackle.  I have always used the Generic in the past with both real OSS 
drivers (before discovering ALSA long ago) and ALSA itself.

[Audio.GenericAudioSubsystem]
UseFilter=True
UseSurround=False
UseStereo=True
UseCDMusic=False
UseDigitalMusic=False
UseSpatial=False
UseReverb=False
Use3dHardware=False
LowSoundQuality=False
ReverseStereo=False
Latency=40
OutputRate=22050Hz
Channels=16
MusicVolume=0
SoundVolume=32
AmbientFactor=0.700000
DopplerSpeed=0.000000

[ALAudio.ALAudioSubsystem]
UseFilter=True
UseSurround=False
UseStereo=True
UseCDMusic=False
UseDigitalMusic=True
UseSpatial=True
UseReverb=True
Use3dHardware=False
LowSoundQuality=False
ReverseStereo=False
Latency=40
OutputRate=22050Hz
Channels=16
MusicVolume=0
SoundVolume=32
AmbientFactor=0.700000
DopplerSpeed=0.000000
MusicBufferSize=16384

Any Ideas?!?
TIA
Johnny O

-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+================================+==================================+
|  John O'Donnell                |                                  |
|  (Sr. Systems Engineer,        |     http://juanisan.homeip.net   |
|  Net Admin, Webmaster, etc.)   |     E-Mail: johnod@covad.net     |
+================================+==================================+


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
