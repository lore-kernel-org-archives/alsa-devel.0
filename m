From: William <walsac3@liam2.demon.co.uk>
Subject: Re: [PATCH] Audigy LS driver ready for inclusion into alsa-driver.
Date: Tue, 1 Jun 2004 16:46:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011546.QAA05204@liam2.demon.co.uk>
References: <s5h8yf7qoqa.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA04054
	for <alsa-devel@alsa-project.org>; Tue, 1 Jun 2004 17:43:22 +0200
In-Reply-To: <s5h8yf7qoqa.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> William wrote:
> "Random intermittent distortion" means, e.g. the sound during MIDI playback
> becomes "muffled" for a minute or two and then returns to normal sound
> quality, or the sound wrongly becomes mono for a few seconds, and then
> returns to stereo.
> Also, it seems emu10k1 does not load soundfonts correctly,
> especially if you ever use any really large 25MB soundfonts.
> 
>> The 25MB piano soundfont is here:
>> http://www.wstco.com/pianosounds/freesoundfont.htm
>> Please note the author Warren has told me his soundfont is not re-distributable.
>> 
>> ALSA soundfont loading:  asfxload WST25FStein_00Aug14.SF2
>> ALSA OSS-mode soundfont loading:  sfxload WST25FStein_00Aug14.SF2
> 
> check /proc/asound/card0/wavetableD* file whether all instruments are
> loaded.  you can see there the memory usage,  number of instruments,
> etc.

Experiment 1:
-------------

Load the 25MB piano soundfont file:
 $ asfxload /tmp/WST25FStein_00Aug14.SF2 
 $ cat /proc/asound/card0/wavetableD*
Device: Emu10k1
Ports: 4
Addresses: 65:0 65:1 65:2 65:3
Use Counter: 0
Max Voices: 64
Allocated Voices: 0
Memory Size: 134217728
Memory Available: 108226960
Allocated Blocks: 45
SoundFonts: 1
Instruments: 4078
Samples: 44
Locked Instruments: 4078
Locked Samples: 44
 $ wget http://members.aol.com/myworks/r-c-no02.mid
 $ aplaymidi -p 65:0 r-c-no02.mid
In this case, you can hear music from the Audigy 2 ZS.

Experiment 2:
-------------

Load the manufacturer's Standard GM Midi file:
 $ asfxload /etc/synthgm.sbk 
 $ cat /proc/asound/card0/wavetableD*
Device: Emu10k1
Ports: 4
Addresses: 65:0 65:1 65:2 65:3
Use Counter: 0
Max Voices: 64
Allocated Voices: 0
Memory Size: 134217728
Memory Available: 134213632
Allocated Blocks: 1
SoundFonts: 1
Instruments: 569
Samples: 152
Locked Instruments: 569
Locked Samples: 152

 $ wget http://members.aol.com/myworks/r-c-no02.mid
 $ aplaymidi -p 65:0 r-c-no02.mid

In this case, there is total silence from the Audigy 2 ZS.

William


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
