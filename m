From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Simple instruments w/ GUS
Date: Tue, 7 May 2002 06:18:12 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020507061812.A8585@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok this is now the third message I've sent about this issue. Jaroslav can
you please say something.

I've written an ALSA sequencer driver for MikMod. It's based on code from
alsamod. The problem is that it won't make any sound. I'm using a GUS
PnP w/ 16 MB. The code is at "http://www.saunalahti.fi/~syrjala/alsa/"

I can open the sequencer, allocate a queue and subscribe to the Interwave
port. Sample loading/unloading seems to work ok.

$ cat /proc/asound/GusPnP/gusmem 
8-bit banks       : 
    0x000000 (4096k),0x400000 (4096k),0x800000 (4096k),0xc00000 (4096k)
16-bit banks      : 
    0x000000 (4096k),0x400000 (4096k),0x800000 (4096k),0xc00000 (4096k)
Block 0 at 0xcbcab394 onboard 0x400000 size 9312 (0x2460):
  Flags           :
  Owner           : SIMPLE wave
Block 1 at 0xcbcab3d4 onboard 0x402460 size 10354 (0x2872):
  Flags           :
  Owner           : SIMPLE wave
...
  Total: memory = 16777216, used = 127016, free = 16650200


Subscribtion works.

$ cat /proc/asound/seq/clients
...
Client  65 : "AMD InterWave" [Kernel]
  Port   0 : "AMD InterWave port 0" (-We-)
    Connected From: 0:1, 128:0
  Port   1 : "AMD InterWave port 1" (-We-)
  Port   2 : "AMD InterWave port 2" (-We-)
  Port   3 : "AMD InterWave port 3" (-We-)
Client 128 : "MikMod" [User]
  Port   0 : "Output" (rwe-)
    Connecting To: 65:0
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 1
    Alloc success      : 6709
    Alloc failures     : 0
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 1
    Alloc success      : 13
    Alloc failures     : 0


Timer is running with the right BPM. Using the system timer.

$ cat /proc/asound/seq/queues 
queue 0: [Queue-0]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 96
current tempo      : 480000
current BPM        : 125
current time       : 1.500000000 s
current tick       : 300


But I don't get any sound. It doesn't even generate interrupts.

$ cat /proc/asound/GusPnP/gusirq 
midi out = 0
midi in = 0
timer1 = 0
timer2 = 0
dma write = 0
dma read = 0
voice lost = 0
voice 0: wave = 0, volume = 0
voice 1: wave = 0, volume = 0
voice 2: wave = 0, volume = 0
...


So what's the problem? Is the driver broken or is it my code? I know this
stuff used to work at some point with alsamod but may the API changes or
whatever broke it.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
