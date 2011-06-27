From: crow <crow@linux.org.ba>
Subject: Re: Realtek ALC662 rev1 no sound over HDMI
Date: Mon, 27 Jun 2011 22:43:30 +0200
Message-ID: <BANLkTi=HHGjUjFix8gQYUu2RKBRZpY+NEA@mail.gmail.com>
References: <BANLkTim2NwanrTtgsYGwHjkyW34fiHuuBQ@mail.gmail.com>
	<s5hr56f3abz.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049D2EC259@HQMAIL01.nvidia.com>
	<BANLkTingUSKSVBRW_Xnh4ALNJnt3FBMTww@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049D2EC34C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1596224332
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 22:43:31 +0200 (CEST)
Received: by iyn35 with SMTP id 35so5321440iyn.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 13:43:31 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049D2EC34C@HQMAIL01.nvidia.com>
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

On Mon, Jun 27, 2011 at 10:06 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Crow wrote at Monday, June 27, 2011 11:49 AM:
>> >> At Sun, 26 Jun 2011 18:45:30 +0200, crow wrote:
>> >> >
>> >> > I am trying to get sound working on kernel 2.6.39 (under archlinux
>> >> > x86_64 bit distribution) over HDMI to my digital receiver but without
>> >> > luck. Before this post i asked in #alsa for help, and everything we
>> >> > tried over there didnt get the sound over HDMI.
>> >> > I connected headphones to the green jack and ran speaker-test and
>> >> > there is sound over jack, analog sound plays fine. But runing
>> >> > alsamixer un-muting spdif/iec958/spdif (1) and trying to re run
>> >> > speaker-test doesn't output sound over HDMI to my digital receiver.
> ...
>> I dont have any GUI here, trough i installed xorg,nvidia,alsa and
>> prepared for VDR/XBMC.
>
> I don't quite understand that last sentence. Just to be clear, audio over
> HDMI isn't expected to work unless the NVIDIA binary X driver is installed,
> X is running, and X is being displayed over HDMI.
>
Well when I was using speaker-test command I was in command line
interface. Nvidia binary X driver is installed and loaded, X isnt
runing, nor is xine. They are started after, with vdrclient startup
script. Trying speaker-test befor X and xine, does not give me any
output to speakres (even, speaker-test plays, no error output just
nothing on speakers). Now i start vdrclient script which do (1) and
(2) and i get sound on speakers. Then i stop vdrclient, and i checked
X isnt runing anymore nor is xine. Did speaker-test again and there is
sound.
Maybe loading X activated something in nvidia driver which activated
then audio to, and even after stoping X, that audio thing is still
activated and can be used??

(1) X -nocursor -br -quiet -dpms -allowMouseOpenFail -ac -audit 0&
(2) xine --no-gui --no-logo --no-splash --deinterlace -pq -f -A alsa
-V vpdau --post vdr --post vdr_audio --post vdr_video --post
tvtime:method=use_vo_driver netvdr:/127.0.0.1
--config=/var/lib/vdr/.xine/config

>> SOLVED:
>> Well I must mark this as solved. Inside .xine/config i have :hdmi as
>> output device defined, and i get sound on my speakers using just HDMI
>> as connection to my digital receiver.
>>...
>> I actualy didnt test it before with xine, and was trying just
>> speaker-test which seems could not output sound over :hdmi (0,3).
>> Maybe there is bug in speaker-test, but then after getting it work
>> with xine i could test it with speaker-test to..
>> Then i reboted my htpc and got it.. It seems HDMI output isnt
>> activated, or speaker-test cant activate it somehow..
>> $ speaker-test -c 2 -r 48000 -D hw:0,3
>> $ speaker-test -c 2 -D hw:0,3
>> Both above command dont work after first boot. And with aplay i get
>> this (command from 13.7. Test Playback With ALSA Physical Devices (1):
>> aplay -D hw:0,3 /usr/share/sounds/alsa/Front_Center.wav
>> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
>> Little Endian, Rate 48000 Hz, Mono
>> aplay: set_params:1065: Channels count non available
>>
>> But if i run xine, which connects to VDR i get sound, and after
>> killing xine, and re-run speaker-test i got audio over HDMI just
>> fine...
>> $ speaker-test -c 2 -r 48000 -D hw:0,3
>> $ speaker-test -c 2 -D hw:0,3
>
> That's odd. I don't understand why running xine first would help.
>
> Perhaps you could try compiling the very latest ALSA kernel driver code,
> and seeing if that makes any difference? Recently, some changes were made
> in the way the HDMI audio infoframes get set up for the chipset you're
> using.
>

I will try to compile latest ALSA kernel driver code, and will let you
know what was the result at the end. Actualy it works now just fine,
as on htpc start vdr and vdrclient scripts are executed and i get
sound woring, but in command line interface before X and xine start
speaker-test fail. And aplay test fail in both case. If i didnt
mentioned I am runing Archlinux x86_64 distribution (used net install
to have up to date packages).
