From: William <walsac3@liam2.demon.co.uk>
Subject: Re: [PATCH] Audigy LS driver ready for inclusion into alsa-driver.
Date: Tue, 1 Jun 2004 14:58:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406011358.OAA04488@liam2.demon.co.uk>
References: <40BC8720.3090801@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA01936
	for <alsa-devel@alsa-project.org>; Tue, 1 Jun 2004 15:55:09 +0200
In-Reply-To: <40BC8720.3090801@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> William wrote:
>> James Courtier-Dutton wrote:
>> 
>>>Audigy LS driver is now ready for inclusion into alsa-driver.
>>>Get it from http://www.superbug.demon.co.uk/alsa
>> 
>> Are you going to work on any other Audigy-series drivers, e.g. Audigy 2 ZS?
>> I'm finding the emu10k1 driver in alsa-driver-1.0.5a has serious problems
>> with random intermittent distortion of the soundfont samples while they are
>> being played on the soundcard's MIDI synthesiser, e.g. using aplaymidi -p 65:0.
>> "Random intermittent distortion" means, e.g. the sound during MIDI playback
>> becomes "muffled" for a minute or two and then returns to normal sound
>> quality, or the sound wrongly becomes mono for a few seconds, and then
>> returns to stereo.
>> Also, it seems emu10k1 does not load soundfonts correctly,
>> especially if you ever use any really large 25MB soundfonts.
> 
> I don't have an Audigy 2 ZS, so unless someone donates one, I can't help 
> you there.

At the moment I also have an Audigy LS (5.1) which seems to have
similar problems to the Audigy 2 ZS.

> Can you post to a web site your soundfonts file, and instructions on how 
> to use them with the creative cards, I might be able to help.

The 25MB piano soundfont is here:
http://www.wstco.com/pianosounds/freesoundfont.htm
Please note the author Warren has told me his soundfont is not re-distributable.

ALSA soundfont loading:  asfxload WST25FStein_00Aug14.SF2
ALSA OSS-mode soundfont loading:  sfxload WST25FStein_00Aug14.SF2

Sample MIDI files for piano: http://members.aol.com/sdrodrian/

 $ aplaymidi -l
  Port    Client name                      Port name
  62:0    Midi Through                     Midi Through Port-0
  64:0    Audigy MPU-401 (UART) - Rawmidi  Audigy MPU-401 (UART)
  64:32   Audigy MPU-401 (UART) - Rawmidi  Audigy MPU-401 #2
  65:0    Emu10k1 WaveTable                Emu10k1 Port 0
  65:1    Emu10k1 WaveTable                Emu10k1 Port 1
  65:2    Emu10k1 WaveTable                Emu10k1 Port 2
  65:3    Emu10k1 WaveTable                Emu10k1 Port 3
  72:0    Virtual Raw MIDI 1-0             VirMIDI 1-0
  73:0    Virtual Raw MIDI 1-1             VirMIDI 1-1
  74:0    Virtual Raw MIDI 1-2             VirMIDI 1-2
  75:0    Virtual Raw MIDI 1-3             VirMIDI 1-3

 $ aplaymidi -p 65:0 midi_music_file.mid

An even better test would be to do some experiments on an Audigy using
Rosegarden 4 0.9.8 for MIDI playback, JACK audio, etc
http://www.rosegardenmusic.com/

> I have a cheepo Audigy 2 (old version) that I might be able to reproduce 
> your problems on.
> 
> I don't work with MIDI much, which is why I have not added MIDI support 
> to the Audigy LS driver at the moment.

I hope you will add MIDI support; I think it would be a great improvement. 

William


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
