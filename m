From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Tue, 14 Dec 2004 20:12:11 -0000 (WET)
Message-ID: <32787.192.168.1.5.1103055131.squirrel@192.168.1.5>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>
    <200412141949.50054.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412141949.50054.annabellesgarden@yahoo.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> Rui Nuno Capela wrote:
>
>> OTOH, on the SUSE desktop I've not been able to run jackd with the
>> 'usx2y' backend driver, always telling me that the 'hwdep' assertion
>> has failed on hwdep.c:588 (this is from memory). On the laptop, where
>> I've been testing the usx2y backend quite extensively, it works just
>> fine as myself has already praised :) Take a note that,o n either box,
>> the snd-usb-usx2y and kernel versions are exactly the same, so are
>> jackd's, currently 0.99.35cvs, but it doesn't matter as the jack_usx2y
>> backend code is still Karsten's original. At first glance, the
>> differences I can point between the two are the hardware (obviously)
>> and the SMP vs. UP kernel. One> thing that now comes to mind is that
>> the snd-usb-usx2y is being loaded as the third soundcard on the failing
>> system and not as the second as once was and I'm sure it used to work
>> the last time I've tried long ago.
>

BINGO! Just did a quick test, by removing the 2nd card (snd-cs46xx) from
modprobe.conf and renumbering snd-usb-usx2y back to index=1, just like
this:

 alias snd-card-1 snd-usb-usx2y
 alias sound-slot-1 snd-usb-usx2y
 options snd-usb-usx2y index=1 enable=1 nrpacks=1

and now I can start 'jackd -R -dusx2y -d:hw:1,2 ...' without the slightest
complaint. The /proc/asound info looks like this:

# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1985 at 0xfebff800, irq 17
1 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 001/003)

# cat /proc/asound/hwdep
01-00: /proc/bus/usb/001/003
01-01: /proc/bus/usb/001/003/hwdeppcm

# cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
01-00: US-X2Y Audio : US-X2Y Audio #0 : playback 1 : capture 1
01-02: US-X2Y hwdep Audio : US-X2Y hwdep Audio : playback 1 : capture 1


Again, If I put back snd-usb-usx2y as index=2,

 alias snd-card-2 snd-usb-usx2y
 alias sound-slot-2 snd-usb-usx2y
 options snd-usb-usx2y index=2 enable=1 nrpacks=1

after alsasound restart, the /proc/asound info becomes:

# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1985 at 0xfebff800, irq 17
1 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xfeafe000/0xfe900000, irq 21
2 [USX2Y          ]: USB US-X2Y - TASCAM US-X2Y
                     TASCAM US-X2Y (1604:8005 if 0 at 001/005)

# cat /proc/asound/hwdep
02-00: /proc/bus/usb/001/005
02-01: /proc/bus/usb/001/005/hwdeppcm

# cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
01-00: CS46xx : CS46xx : playback 31 : capture 1
01-01: CS46xx - Rear : CS46xx - Rear : playback 31
01-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
01-03: CS46xx - Center LFE : CS46xx - Center LFE : playback 31
02-00: US-X2Y Audio : US-X2Y Audio #0 : playback 1 : capture 1
02-02: US-X2Y hwdep Audio : US-X2Y hwdep Audio : playback 1 : capture 1

And, starting 'jackd -R -dusx2y -dhw:2,2 ...' ends abnormally, with the
error line:

jackd: hwdep.c:263: snd_hwdep_poll_descriptors: Assertion `hwdep' failed.

>
> Could be that assert:
> const char *snd_hwdep_dsp_status_get_id(const snd_hwdep_dsp_status_t *obj)
> {
>  assert(obj);
>  return obj->id;
> }
>
> Mmmh,,,,,, what could cause it ?
> Rui: Just 1 idea: Does this also happen, when jackd is started as root?
> I had udev assigning some devices rights to root only occasionally.
>

Nope. Staring as root gives exactly the same result.

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
