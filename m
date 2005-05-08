From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001090]: Support for new Prodigy 7.1 LT
Date: Mon, 9 May 2005 01:01:26 +0200
Message-ID: <df0d076dbd28238ce990b3994b52fd94@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AA96327C
	for <alsa-devel@alsa-project.org>; Mon,  9 May 2005 01:01:26 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1090> 
======================================================================
Reported By:                Demosthenes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1090
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Ubuntu (Hoary Hedgehog)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             05-06-2005 17:34 CEST
Last Modified:              05-09-2005 01:01 CEST
======================================================================
Summary:                    Support for new Prodigy 7.1 LT
Description: 
Could you please try to add support for the Audiotrak Prodigy 7.1 LT, as
far as I am aware this card is essentially the same as the Produgy 7.1 but
low profile and with a couple of physical changes such as no digital in.

ALSA does not detect the card currently and when I try to load the
snd-1724 module it fails with an EEPROM error.

I have tried compiling a new kernel with the subdevice id for the Prodigy
7.1 in aureon.h changed to correspond to my device (as detailed here for
another card
http://linux.derkeiler.com/Newsgroups/comp.os.linux.hardware/2004-10/0340.html).
Alsa then detects the card and I can load modules and change volumes in
alsamixer but I haven't been able to produce any sound.

Hopefully support will be easy to add as this card is almost exactly the
same as the Prodigy 7.1 (and Aureon Space etc.) which already have
support.

I would be very happy to give any further information needed.
======================================================================

----------------------------------------------------------------------
 Demosthenes - 05-08-05 20:37 
----------------------------------------------------------------------
'amixer contents':

numid=1,iface=CARD,name='ICE1724 EEPROM'
  ; type=BYTES,access=r----,values=52
  :
values=0x41,0x54,0x31,0x32,0x13,0x02,0x0b,0x80,0xfc,0xc1,0xff,0xff,0x5f,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x5f,0x00
numid=20,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=21,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=255,step=0
  : values=178,178
numid=32,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=33,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=128,step=0
  : values=90
numid=26,iface=MIXER,name='Center Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=27,iface=MIXER,name='Center Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
  : values=120
numid=28,iface=MIXER,name='LFE Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=29,iface=MIXER,name='LFE Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
  : values=120
numid=46,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=47,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=23,23
numid=42,iface=MIXER,name='CD Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=43,iface=MIXER,name='CD Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=22,22
numid=50,iface=MIXER,name='Mic Boost (+20dB)'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=48,iface=MIXER,name='Mic Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=49,iface=MIXER,name='Mic Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=29
numid=44,iface=MIXER,name='Aux Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=45,iface=MIXER,name='Aux Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=23,23
numid=39,iface=MIXER,name='ADC Oversampling'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 '128x'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 '64x'
  : values=0
numid=36,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'CD'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'Aux'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'Line'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'Mic'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'AC97'
  : values=0,0
numid=34,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=35,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=18,iface=MIXER,name='IEC958 Playback Con Mask',device=1
  ; type=IEC958,access=r----,values=1
  : values=?
numid=19,iface=MIXER,name='IEC958 Playback Pro Mask',device=1
  ; type=IEC958,access=r----,values=1
  : values=?
numid=14,iface=MIXER,name='IEC958 Playback Route'
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=15,iface=MIXER,name='IEC958 Playback Route',index=1
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=4
numid=16,iface=MIXER,name='IEC958 Output Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=40,iface=MIXER,name='AC97 Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=41,iface=MIXER,name='AC97 Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=31,31
numid=38,iface=MIXER,name='DAC Deemphasis Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=37,iface=MIXER,name='External Amplifier'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=22,iface=MIXER,name='Front Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=23,iface=MIXER,name='Front Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=127,step=0
  : values=126,126
numid=5,iface=MIXER,name='H/W Playback Route'
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=6,iface=MIXER,name='H/W Playback Route',index=1
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=7,iface=MIXER,name='H/W Playback Route',index=2
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=8,iface=MIXER,name='H/W Playback Route',index=3
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=9,iface=MIXER,name='H/W Playback Route',index=4
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=10,iface=MIXER,name='H/W Playback Route',index=5
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=11,iface=MIXER,name='H/W Playback Route',index=6
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=12,iface=MIXER,name='H/W Playback Route',index=7
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 'PCM Out'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 'H/W In 0'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 'H/W In 1'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 'IEC958 In L'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 'IEC958 In R'
  : values=0
numid=2,iface=MIXER,name='Multi Track Internal Clock'
  ; type=ENUMERATED,access=rw---,values=1,items=16
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 '8000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 '9600'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 '11025'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 '12000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 '16000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5 '22050'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6 '24000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7 '32000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8 '44100'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9 '48000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 '64000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11 '88200'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12 '96000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13 '176400'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 '192000'
  ; Item https://bugtrack.alsa-project.org/alsa-bug/view.php?id=15 'IEC958
Input'
  : values=8
numid=13,iface=MIXER,name='Multi Track Peak'
  ; type=INTEGER,access=r----,values=22,min=0,max=255,step=0
  : values=255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
numid=3,iface=MIXER,name='Multi Track Rate Locking'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=4,iface=MIXER,name='Multi Track Rate Reset'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=24,iface=MIXER,name='Rear Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=25,iface=MIXER,name='Rear Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=127,step=0
  : values=117,117
numid=30,iface=MIXER,name='Side Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=31,iface=MIXER,name='Side Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=127,step=0
  : values=126,126
numid=17,iface=PCM,name='IEC958 Playback Default',device=1
  ; type=IEC958,access=rw---,values=1
  : values=?


'cat /proc/asound/card0/ice1724' :

Audiotrak Prodigy 7.1 LT at 0xd000, irq 18

EEPROM:
  Subvendor        : 0x32315441
  Size             : 19 bytes
  Version          : 2
  System Config    : 0xb
  ACLink           : 0x80
  I2S              : 0xfc
  S/PDIF           : 0xc1
  GPIO direction   : 0x5fffff
  GPIO mask        : 0x0
  GPIO state       : 0x0
  Extra https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18        : 0x0

Registers:
  PSDOUT03 : 0x00000038
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x0b
  CCS05    : 0x80
  CCS06    : 0xfc
  CCS07    : 0xc1
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x32
  CCS13    : 0x80
  CCS14    : 0x00
  CCS15    : 0x10
  CCS16    : 0x00
  CCS17    : 0x00
  CCS18    : 0xff
  CCS19    : 0xff
  CCS1a    : 0x5f
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x7f
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x08
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x00
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0xa0
  MT12     : 0xf5
  MT13     : 0x37
  MT14     : 0xff
  MT15     : 0x17
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x03
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0xff
  MT1d     : 0x01
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0xff
  MT27     : 0x1f
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x38
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

Just no sound, there is no error or anything.

----------------------------------------------------------------------
 ungod - 05-09-05 01:01 
----------------------------------------------------------------------
Well, I must admit that the sound is quite low, when the volume is set as
yours, however it ought to work.
The VU meter (Multi Track Peak) have detected audio on both front
channels.
Have you tried with Master, PCM and Front volumes set to max? Or even with
External Amplifier on? (Beware of this one though, the volume is increased
dramatically)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 17:34 Demosthenes    New Issue                                    
05-06-05 17:35 Demosthenes    Distribution              => Ubuntu (Hoary
Hedgehog)
05-06-05 17:35 Demosthenes    Kernel Version            => 2.6.10          
05-06-05 22:44 ungod          Note Added: 0004597                          
05-06-05 22:48 ungod          Note Added: 0004598                          
05-07-05 01:38 Demosthenes    Note Added: 0004600                          
05-07-05 01:47 Demosthenes    Note Edited: 0004600                         
05-08-05 00:45 ungod          Note Added: 0004608                          
05-08-05 17:30 Demosthenes    Note Added: 0004610                          
05-08-05 17:39 ungod          File Added: aureon-prodigy71lt-fix.diff           
        
05-08-05 17:40 ungod          Note Added: 0004611                          
05-08-05 19:09 Demosthenes    Note Added: 0004612                          
05-08-05 19:12 Demosthenes    Note Edited: 0004612                         
05-08-05 19:12 Demosthenes    Note Edited: 0004612                         
05-08-05 20:08 ungod          Note Added: 0004614                          
05-08-05 20:18 Demosthenes    Note Added: 0004615                          
05-08-05 20:23 ungod          Note Added: 0004616                          
05-08-05 20:27 ungod          Note Added: 0004617                          
05-08-05 20:37 Demosthenes    Note Added: 0004618                          
05-09-05 01:01 ungod          Note Added: 0004620                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
