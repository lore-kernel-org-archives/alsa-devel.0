From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 23 Oct 2008 23:55:05 +0100
Message-ID: <490100C9.7030907@oliford.co.uk>
References: <48FF7538.3090000@oliford.co.uk>	<20081022205729.GD7537@sirena.org.uk>	<48FFAFB1.1090106@oliford.co.uk>	<20081023140015.GA17901@sirena.org.uk>
	<4900851D.2050001@oliford.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080004040203050508020908"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id D3F12244AF
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 00:55:25 +0200 (CEST)
In-Reply-To: <4900851D.2050001@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080004040203050508020908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Oliver Ford wrote:

>>         name 'Speaker Playback Volume'
>>         value 1
>>     }
>>         
This is unrelated, I have just left it there from playing around.


>
>> One other thing that would be useful would be to put trace which logs
>> the register writes in ac97_write() in the driver and then try testing
>> both using alsamixer and then amixer to do the final enable of the
>> Speaker Mixer PCM Playback Switch.
>>       
Well...

In terms of the control's direct effect, setting it in alsamixer gives:
pxa2xx_ac97_write: 0c = af08

setting it in amixer:
pxa2xx_ac97_write: 0c = af09



Am I right in understanding that setting all the controls in amixer 
doesn't actually enable the control in the codec chip at that time but 
that the powering on/off is done by soc-dapm.c when the the DAC is 
actually enabled when playing some audio? This appears to be what is 
happening when it does work (looking at the log). I hadn't realised this.

However, after running the offending amixer command this no longer 
happens. It seems that the dapm_power_widgets() function determines that 
the DAC is off and so doesn't power any widgets on at all.

I've put some debugging in pxa2xx-ac97-write and in dapm_power_widgets() 
and the log is attached (stripped of non-audio stuff).



Oliver

--------------080004040203050508020908
Content-Type: text/plain;
 name="consolelog-dapm-and-ac97regs-amixer-fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consolelog-dapm-and-ac97regs-amixer-fail.txt"

Clean boot...


** run speaker.sh setup without PCM->speaker setting... **
pxa2xx_ac97_write: 000c = ef08
pxa2xx_ac97_write: 001c = 0002
pxa2xx_ac97_write: 001c = 1802
pxa2xx_ac97_write: 001e = 0800
pxa2xx_ac97_write: 0006 = 0081
pxa2xx_ac97_write: 0002 = 0080

** run alsamixer, set PCM->speaker on: ** 
pxa2xx_ac97_write: 000c = af08


# aplay /stuff/400Hz-wav.wav
+hpipaq214_startup()
hpipaq214-audio: Enabling iPAQ Speaker...
hpipaq214_startup, gpio96 -> on
-hpipaq214_startup()

Playing WAVE '/stuff/400Hz-wav.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
pxa2xx_ac97_write: 002a = 0411
pxa2xx_ac97_write: 002c = ac44
DAPM: Path Widget 'DAC Inv Mux 2': off --> on
DAPM: Path Widget 'Out 4 Mux': off --> on
DAPM: Path Widget 'Left Speaker Out Mux': off --> on
DAPM: DAC Widget 'Right DAC': off --> on (w->active==1)
pxa2xx_ac97_write: 003c = 3abf
DAPM: DAC Widget 'Left DAC': off --> on (w->active==1)
pxa2xx_ac97_write: 003c = 3a3f
DAPM: Path Widget 'AC97 Mixer': off --> on
DAPM: Path Widget 'Speaker Mixer': off --> on
pxa2xx_ac97_write: 003c = 3a3d
DAPM: Path Widget 'Out 4': off --> on
pxa2xx_ac97_write: 003e = efff
DAPM: Path Widget 'Left Speaker': off --> on
pxa2xx_ac97_write: 003e = eeff
freq changed, set PCD to 5 (LCCR3 = 04700005, LCCR4 = 80000000)
DAPM: Path Widget 'iPAQ Speaker': off --> on
pxa2xx_ac97_write: 003c = 1a3d
hpipaq214_shutdown, gpio96 -> off

** aplay exits. **

** ... few seconds delay ... **

DAPM: Path Widget 'iPAQ Speaker': on --> off
DAPM: Path Widget 'Out 4': on --> off
pxa2xx_ac97_write: 003e = feff
DAPM: Path Widget 'Left Speaker': on --> off
pxa2xx_ac97_write: 003e = ffff
DAPM: Path Widget 'AC97 Mixer': on --> off
DAPM: Path Widget 'Speaker Mixer': on --> off
pxa2xx_ac97_write: 003c = 1a3f
DAPM: Path Widget 'Right DAC': on --> off
pxa2xx_ac97_write: 003c = 1a7f
DAPM: Path Widget 'Left DAC': on --> off
pxa2xx_ac97_write: 003c = 1aff
DAPM: Path Widget 'DAC Inv Mux 2': on --> off
DAPM: Path Widget 'Out 4 Mux': on --> off
DAPM: Path Widget 'Left Speaker Out Mux': on --> off
pxa2xx_ac97_write: 003c = 1aff
pxa2xx_ac97_write: 0026 = 0000


** all quiet **

#
#
# amixer cset numid=62 1 
pxa2xx_ac97_write: 000c = af09
numid=62,iface=MIXER,name='Speaker Mixer PCM Playback Swit'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on



# aplay /stuff/400Hz-wav.wav
+hpipaq214_startup()
hpipaq214-audio: Enabling iPAQ Speaker...
hpipaq214_startup, gpio96 -> on
-hpipaq214_startup()

Playing WAVE '/stuff/400Hz-wav.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
freq changed, set PCD to 5 (LCCR3 = 04700005, LCCR4 = 80000000)
pxa2xx_ac97_write: 002a = 0411
pxa2xx_ac97_write: 002c = ac44
DAPM: DAC Widget 'Right DAC': off --> off (w->active==1)
DAPM: DAC Widget 'Left DAC': off --> off (w->active==1)
pxa2xx_ac97_write: 003c = 1aff
hpipaq214_shutdown, gpio96 -> off
# 
#
pxa2xx_ac97_write: 003c = 1aff
pxa2xx_ac97_write: 0026 = 0000

--------------080004040203050508020908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080004040203050508020908--
