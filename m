From: Nick Arnold <nick.arnold@nautronix.com.au>
Subject: Re: RME Hammerfall HDSP 9652
Date: Mon, 1 Sep 2003 17:59:28 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030901175928.B22322@nautronix.com.au>
References: <20030827160852.D21247@nautronix.com.au> <34419.80.13.13.11.1061984366.squirrel@www.undata.org> <20030828182641.A28493@nautronix.com.au> <32941.193.253.35.6.1062074441.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_NextPart_ST_17_59_30_Monday_September_01_2003_7730"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <32941.193.253.35.6.1062074441.squirrel@www.undata.org>; from thomas@undata.org on Thu, Aug 28, 2003 at 02:40:41PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


----=_NextPart_ST_17_59_30_Monday_September_01_2003_7730
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello again,

We seem to have got the card working both for capture and playback(!).

Thanks to everyone for their replies.  We were not expecting so much positive
response.  If any of the respondants are in Fremantle Perth sometime send us
an email and we'll take you to lunch!

The three things we did:

1) applied the patch to the hdsp driver.  This solved (rather than
"ameliorated" as I incorrectly wrote earlier) the unexplained signal on the
output channels.

2) found the right "amixer" settings for our setup:

        #!/bin/bash

        amixer -c 0 cset numid=11 0
        amixer -c 0 cset numid=13 0

        for i in $(seq 1 26);do
            amixer -c 0 cset name=Chn,index=$i 32768
        done

   - ie. the sync reference was an external word clock, so the card should
     not use any internal clock source; and output channels should be turned
     on.

   (I neglected to mention earlier that we have an external work clock source
   and hence the card must run as a slave and not use any of the "Internal
   XXX kHz" sample source clock settings.  It took me awhile to realise the
   importance of this piece of information.)

3) changed to a working AD/DA converter box. :)  Almost at the point of
giving-up we swapped to a different AD/DA converter box and found the card
worked!  

I've attached the output of "amixer contents" and the interesting bit of the
output of "lspci -vv" for the curious.  You'll notice the card is presenting
as having 26 channels.  This has meant we have needed no changes to our
software from the "old" Hammerfall.

Our software was originally written to work with the "old" Hammerfall -- I
believe now called the DIGI 9652.  To the best of our understanding that card
had no knowledge of ADAT "double speed" and hence we opened the card
requesting 48kHz sampling and 26 channels.  We did the (de-)interleaving of
channels ourselves.  This was done because we were under the impression it
would support no other setttings.  

Now this software is running without change with the new card -- ie. 26
channels; 48kHz; and we're doing the (de-)interleaving.  This is a great
result.

If this card is capable of performing the channel (de-)interleaving for us
under our setup (a slave device auto-syncing to the word clock) we'll
probably start looking into getting this working sometime soon, but its a
lower priority.

Anyway, thanks everyone for your help,

nick.
--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  Any views or opinions presented are solely those of the author and do not necessarily represent those of Nautronix Ltd.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of this email is strictly prohibited.  If you have received this email in error please contact the sender.

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such
e-mail messages and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability on our part arising directly or indirectly out of any virus is excluded.
Please ensure that you run virus checking software on all e-mail messages and attachments before reading them.
----=_NextPart_ST_17_59_30_Monday_September_01_2003_7730
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amixer_contents.txt"

numid=49,iface=HWDEP,name='ADAT Lock Status',index=1
  ; type=ENUMERATED,access=r----,values=1,items=3
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  : values=2
numid=50,iface=HWDEP,name='ADAT Lock Status',index=2
  ; type=ENUMERATED,access=r----,values=1,items=3
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  : values=2
numid=51,iface=HWDEP,name='ADAT Lock Status',index=3
  ; type=ENUMERATED,access=r----,values=1,items=3
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  : values=2
numid=20,iface=HWDEP,name='ADAT Sync Lock Status'
  ; type=ENUMERATED,access=r----,values=1,items=3
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  : values=0
numid=14,iface=HWDEP,name='AutoSync Reference'
  ; type=ENUMERATED,access=r----,values=1,items=7
  ; Item #0 'Word'
  ; Item #1 'ADAT Sync'
  ; Item #2 'IEC958'
  ; Item #3 'None'
  ; Item #4 'ADAT1'
  ; Item #5 'ADAT2'
  ; Item #6 'ADAT3'
  : values=0
numid=9,iface=HWDEP,name='IEC958 Emphasis Bit'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=10,iface=HWDEP,name='IEC958 Non-audio Bit'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=7,iface=HWDEP,name='IEC958 Output also on ADAT1'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=8,iface=HWDEP,name='IEC958 Professional Bit'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=22,iface=HWDEP,name='Line Out'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=5,iface=HWDEP,name='Mixer'
  ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
  : values=0,0,0
numid=21,iface=HWDEP,name='Passthru'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=13,iface=HWDEP,name='Preferred Sync Reference'
  ; type=ENUMERATED,access=rw---,values=1,items=6
  ; Item #0 'Word'
  ; Item #1 'ADAT Sync'
  ; Item #2 'IEC958'
  ; Item #3 'ADAT1'
  ; Item #4 'ADAT2'
  ; Item #5 'ADAT3'
  : values=0
numid=19,iface=HWDEP,name='SPDIF Lock Status'
  ; type=ENUMERATED,access=r----,values=1,items=3
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  : values=0
numid=15,iface=HWDEP,name='SPDIF Sample Rate'
  ; type=ENUMERATED,access=r----,values=1,items=7
  ; Item #0 '32000'
  ; Item #1 '44100'
  ; Item #2 '48000'
  ; Item #3 '64000'
  ; Item #4 '88200'
  ; Item #5 '96000'
  ; Item #6 'None'
  : values=6
numid=12,iface=HWDEP,name='System Clock Mode'
  ; type=ENUMERATED,access=r----,values=1,items=2
  ; Item #0 'Master'
  ; Item #1 'Slave'
  : values=1
numid=16,iface=HWDEP,name='System Sample Rate'
  ; type=INTEGER,access=r----,values=1,min=0,max=0,step=0
  : values=48000
numid=18,iface=HWDEP,name='Word Clock Lock Status'
  ; type=ENUMERATED,access=r----,values=1,items=3
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  : values=2
numid=3,iface=MIXER,name='IEC958 Playback Con Mask'
  ; type=IEC958,access=r----,values=1
  : values=?
numid=4,iface=MIXER,name='IEC958 Playback Pro Mask'
  ; type=IEC958,access=r----,values=1
  : values=?
numid=23,iface=MIXER,name='Chn',index=1
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=24,iface=MIXER,name='Chn',index=2
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=25,iface=MIXER,name='Chn',index=3
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=26,iface=MIXER,name='Chn',index=4
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=27,iface=MIXER,name='Chn',index=5
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=28,iface=MIXER,name='Chn',index=6
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=29,iface=MIXER,name='Chn',index=7
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=30,iface=MIXER,name='Chn',index=8
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=31,iface=MIXER,name='Chn',index=9
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=32,iface=MIXER,name='Chn',index=10
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=33,iface=MIXER,name='Chn',index=11
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=34,iface=MIXER,name='Chn',index=12
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=35,iface=MIXER,name='Chn',index=13
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=36,iface=MIXER,name='Chn',index=14
  ; type=INTEGER,access=rw---,values=1,min=0,max=65536,step=1
  : values=32768
numid=37,iface=MIXER,name='Chn',index=15
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=38,iface=MIXER,name='Chn',index=16
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=39,iface=MIXER,name='Chn',index=17
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=40,iface=MIXER,name='Chn',index=18
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=41,iface=MIXER,name='Chn',index=19
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=42,iface=MIXER,name='Chn',index=20
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=43,iface=MIXER,name='Chn',index=21
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=44,iface=MIXER,name='Chn',index=22
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=45,iface=MIXER,name='Chn',index=23
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=46,iface=MIXER,name='Chn',index=24
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=47,iface=MIXER,name='Chn',index=25
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=48,iface=MIXER,name='Chn',index=26
  ; type=INTEGER,access=rw-v-,values=1,min=0,max=65536,step=1
  : values=32768
numid=17,iface=PCM,name='External Rate'
  ; type=ENUMERATED,access=r----,values=1,items=7
  ; Item #0 '32000'
  ; Item #1 '44100'
  ; Item #2 '48000'
  ; Item #3 '64000'
  ; Item #4 '88200'
  ; Item #5 '96000'
  ; Item #6 'None'
  : values=2
numid=6,iface=PCM,name='IEC958 Input Connector'
  ; type=ENUMERATED,access=rw---,values=1,items=3
  ; Item #0 'ADAT1'
  ; Item #1 'Coaxial'
  ; Item #2 'Internal'
  : values=2
numid=1,iface=PCM,name='IEC958 Playback Default'
  ; type=IEC958,access=rw---,values=1
  : values=?
numid=11,iface=PCM,name='Sample Clock Source'
  ; type=ENUMERATED,access=rw---,values=1,items=7
  ; Item #0 'AutoSync'
  ; Item #1 'Internal 32.0 kHz'
  ; Item #2 'Internal 44.1 kHz'
  ; Item #3 'Internal 48.0 kHz'
  ; Item #4 'Internal 64.0 kHz'
  ; Item #5 'Internal 88.2 kHz'
  ; Item #6 'Internal 96.0 kHz'
  : values=0

----=_NextPart_ST_17_59_30_Monday_September_01_2003_7730
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"


02:05.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP
    (rev 64)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
             ParErr- Step ping- SERR- FastB2B- Status: Cap- 66Mhz-
             UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort -
             <MAbort- >SERR- <PERR- Latency: 64
    Interrupt: pin A routed to IRQ 9
    Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]

----=_NextPart_ST_17_59_30_Monday_September_01_2003_7730--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
