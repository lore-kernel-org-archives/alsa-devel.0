From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Tue, 20 Apr 2004 21:25:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404202125.12660.bero@arklinux.org>
References: <200404171945.35824.bero@arklinux.org> <200404201939.54966.bero@arklinux.org> <20040420183931.GB2166@sirius.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040420183931.GB2166@sirius.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Sergey Vlasov <vsu@altlinux.ru>
List-Id: alsa-devel@alsa-project.org

On Tuesday 20 April 2004 20:39, Sergey Vlasov wrote:
> > > > On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID
> > > > 1019:0f22), snd_ali5451 loads and can adjust mixer settings (except
> > > > for PCM volume, but I think that's a limitation of the hardware), but
> > > > doesn't make any noise - apparently PCM is always muted (volume fixed
> > > > at 0?).
>
> And what does "amixer contents" show?

numid=9,iface=MIXER,name='Master Mono Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=10,iface=MIXER,name='Master Mono Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=31
numid=1,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=2,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=31,31
numid=26,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=7,iface=MIXER,name='Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=8,iface=MIXER,name='Surround Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=31,31
numid=3,iface=MIXER,name='Center Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=4,iface=MIXER,name='Center Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=5,iface=MIXER,name='LFE Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=6,iface=MIXER,name='LFE Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=41,iface=MIXER,name='Line-In As Surround'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=18,iface=MIXER,name='Line Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=19,iface=MIXER,name='Line Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=20,iface=MIXER,name='CD Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=21,iface=MIXER,name='CD Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=17,iface=MIXER,name='Mic Boost (+20dB)'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=31,iface=MIXER,name='Mic Select'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'Mic1'
  ; Item #1 'Mic2'
  : values=0
numid=15,iface=MIXER,name='Mic Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=16,iface=MIXER,name='Mic Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=13,iface=MIXER,name='Phone Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=14,iface=MIXER,name='Phone Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=31,step=0
  : values=0
numid=22,iface=MIXER,name='Video Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=23,iface=MIXER,name='Video Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=11,iface=MIXER,name='PC Speaker Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=12,iface=MIXER,name='PC Speaker Playback Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0
  : values=0
numid=24,iface=MIXER,name='Aux Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=25,iface=MIXER,name='Aux Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0
numid=30,iface=MIXER,name='Mono Output Select'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'Mix'
  ; Item #1 'Mic'
  : values=0
numid=27,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Mic'
  ; Item #1 'CD'
  ; Item #2 'Video'
  ; Item #3 'Aux'
  ; Item #4 'Line'
  ; Item #5 'Mix'
  ; Item #6 'Mix Mono'
  ; Item #7 'Phone'
  : values=5,5
numid=28,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=29,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=15,step=0
  : values=0,0
numid=38,iface=MIXER,name='IEC958 Capture Valid Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=32,iface=MIXER,name='IEC958 Playback Con Mask'
  ; type=IEC958,access=r----,values=1
  : values=?
numid=33,iface=MIXER,name='IEC958 Playback Pro Mask'
  ; type=IEC958,access=r----,values=1
  : values=?
numid=36,iface=MIXER,name='IEC958 Playback AC97-SPSA'
  ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
  : values=3
numid=34,iface=MIXER,name='IEC958 Playback Default'
  ; type=IEC958,access=rw---,values=1
  : values=?
numid=37,iface=MIXER,name='IEC958 Playback Source'
  ; type=ENUMERATED,access=rw---,values=1,items=2
  ; Item #0 'Analog'
  ; Item #1 'Digital'
  : values=0
numid=35,iface=MIXER,name='IEC958 Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=39,iface=MIXER,name='IEC958 Capture Monitor'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=40,iface=MIXER,name='IEC958 Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=42,iface=MIXER,name='External Amplifier'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
