From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: [PATCH] ALSA: usb-audio: fix automatic
	Roland/Yamaha MIDI detection
Date: Mon, 12 Aug 2013 23:00:07 +0100
Message-ID: <3133270.FSXLdSxQFT@kamdesktop>
References: <51CC9D8B.7060601@ladisch.de> <2663331.bA47oXYmkZ@kamdesktop>
 <52077FD9.6060404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f170.google.com (mail-ea0-f170.google.com
 [209.85.215.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 24160265019
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 00:00:10 +0200 (CEST)
Received: by mail-ea0-f170.google.com with SMTP id h14so3815227eak.1
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 15:00:09 -0700 (PDT)
In-Reply-To: <52077FD9.6060404@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 11 Aug 2013 14:13:13 Clemens Ladisch wrote:
> Commit aafe77cc45a5 (ALSA: usb-audio: add support for many Roland/Yamaha
> devices) had several logic errors that prevented create_auto_midi_quirk
> from enumerating any MIDI ports.
> 
> Reported-by: Keith A. Milner <maillist@superlative.org>
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

I've just got around for testing this. Debug logfile at the bottom.

Playback and record interfaces are correctly listed:

$ aplay -l
...
card 3: JS8 [JS-8], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ arecord -l
...
card 3: JS8 [JS-8], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

This time, the MIDI interfaces are also listed:

$ amidi -l
Dir Device    Name
IO  hw:3,0,0  JS-8 MIDI 1
IO  hw:3,0,1  JS-8 MIDI 2

(By the way, I still have no idea what these MIDI ports do, if anything. there 
seems to be no ooutput from the JS-8 MIDI, and it doesn't seem to respond to 
any of the MIDI events I have tried sending to it. It's possible it's used for 
some sort of Sysex, or maybe it's vestigial.)

I tested it with simultaneous playback and record using Ardour3 and it works 
great.

Cheers,

Keith

(Debug log below)

Aug 12 22:35:42 KAMDesktop kernel: [  259.081313] usb 1-6.2: new high-speed 
USB device number 7 using ehci-pci
Aug 12 22:35:42 KAMDesktop mtp-probe: checking bus 1, device 7: 
"/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-6/1-6.2"
Aug 12 22:35:42 KAMDesktop kernel: [  259.174567] 7:0:1: add audio endpoint 
0x5
Aug 12 22:35:42 KAMDesktop kernel: [  259.174948] 7:1:1: add audio endpoint 
0x84
Aug 12 22:35:42 KAMDesktop kernel: [  259.175191] switching to altsetting 1 
with int ep
Aug 12 22:35:42 KAMDesktop kernel: [  259.175322] created 2 output and 2 input 
ports
Aug 12 22:35:42 KAMDesktop mtp-probe: bus: 1, device: 7 was not an MTP device
Aug 12 22:35:42 KAMDesktop kernel: [  259.191386] setting usb interface 0:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.191389] Creating new playback data 
endpoint #5
Aug 12 22:35:42 KAMDesktop kernel: [  259.191392] Creating new capture data 
endpoint #84
Aug 12 22:35:42 KAMDesktop kernel: [  259.191549] Setting params for ep #5 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.191551] match_endpoint_audioformats: 
(fmt @ffff8802ea269080) score 2
Aug 12 22:35:42 KAMDesktop kernel: [  259.191556] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.191557] Starting data EP 
@ffff8802d3760000
Aug 12 22:35:42 KAMDesktop kernel: [  259.191722] Starting sync EP 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.204108] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.204110] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.204118] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.204135] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.204136] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.204150] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.204298] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.204493] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.204496] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.204581] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.204710] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.205367] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.205369] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.205374] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.205385] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.205387] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.205400] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.205541] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.205668] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.205671] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.205760] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.205793] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.206369] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.206371] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.206376] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.206395] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.206397] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.206437] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.206574] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.206863] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.206865] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.206978] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.207152] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.207870] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.207872] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.207880] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.207908] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.207912] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.207964] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.208108] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.208354] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.208360] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.208480] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.208623] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.209269] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.209272] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.209280] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.209293] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.209295] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.209307] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.209337] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.209433] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.209435] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.209524] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.209556] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.210124] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.210126] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.210131] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.210143] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.210145] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.210158] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.210332] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.210546] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.210548] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.210633] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.210774] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.211375] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.211377] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.211382] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.211400] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.211402] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.211459] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.211601] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.211843] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.211845] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.211953] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.212091] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.212752] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.212753] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.212761] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.212788] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.212793] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.212844] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.212988] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.213165] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.213170] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.213300] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.213312] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.213879] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.213880] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.213885] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.213895] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.213897] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.213909] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.214037] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.214241] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.214243] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.214328] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.214537] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.215255] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.215257] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.215261] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.215272] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.215274] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.215286] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.215494] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.215775] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.215777] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.215861] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.216067] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.217008] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.217010] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.217015] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.217033] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.217035] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.217075] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.217148] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.217297] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.217300] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.217412] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.217464] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.218260] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.218261] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.218269] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.218297] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.218301] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.218353] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.218495] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.218742] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.218747] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.218866] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.219008] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.232782] setting usb interface 0:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.232784] Re-using EP 5 in iface 0,1 
@ffff8802d3760000
Aug 12 22:35:42 KAMDesktop kernel: [  259.232786] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.232828] Setting params for ep #5 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.232829] match_endpoint_audioformats: 
(fmt @ffff8802ea269080) score 2
Aug 12 22:35:42 KAMDesktop kernel: [  259.232832] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.232833] Starting data EP 
@ffff8802d3760000
Aug 12 22:35:42 KAMDesktop kernel: [  259.233028] Starting sync EP 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.245961] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.245963] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.245970] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.245985] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.245988] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.246004] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.246013] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.246129] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.246131] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.246231] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.246237] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.246832] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.246834] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.246840] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.246854] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.246857] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.246872] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.246956] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.247134] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.247137] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.247225] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.247361] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.248051] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.248053] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.248058] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.248076] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.248078] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.248118] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.248262] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.248400] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.248402] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.248509] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.248516] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249052] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.249054] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249063] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249090] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249095] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249146] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249155] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249270] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249276] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249404] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249415] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249929] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.249930] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249935] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249945] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.249947] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.249959] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250007] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250091] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250093] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250178] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250215] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250679] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.250681] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250685] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250696] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250697] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250709] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250743] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250822] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250825] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.250908] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.250942] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.251431] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.251432] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.251437] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.251455] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.251457] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.251497] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.251532] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.251668] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.251671] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.251779] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.251815] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.252432] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.252434] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.252441] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.252469] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.252473] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.252524] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.252565] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.252709] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.252714] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.252835] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.252872] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.253464] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.253466] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.253472] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.253485] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.253487] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.253500] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.253643] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.253743] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.253745] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.253835] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.253979] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.254708] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.254712] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.254720] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.254738] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.254742] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.254759] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.254896] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.255110] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.255112] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.255196] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.255302] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.255948] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.255950] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.255955] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.255975] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.255977] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.256017] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.256023] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.256148] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.256153] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.256288] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.256296] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.257065] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.257067] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.257076] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.257106] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.257110] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.257162] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.257171] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.257284] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.257289] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.257421] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.257430] Unable to change format on 
ep #84: already in use
Aug 12 22:35:42 KAMDesktop kernel: [  259.258692] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.258693] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.258733] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.260569] setting usb interface 1:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.260570] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.260612] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.261947] setting usb interface 0:1
Aug 12 22:35:42 KAMDesktop kernel: [  259.261948] Re-using EP 5 in iface 0,1 
@ffff8802d3760000
Aug 12 22:35:42 KAMDesktop kernel: [  259.261949] Re-using EP 84 in iface 1,1 
@ffff8802ce9d0000
Aug 12 22:35:42 KAMDesktop kernel: [  259.261993] Setting params for ep #5 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.261994] match_endpoint_audioformats: 
(fmt @ffff8802ea269080) score 2
Aug 12 22:35:42 KAMDesktop kernel: [  259.261996] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 12 22:35:42 KAMDesktop kernel: [  259.261997] Starting data EP 
@ffff8802d3760000
Aug 12 22:35:42 KAMDesktop kernel: [  259.262194] Starting sync EP 
@ffff8802ce9d0000
Aug 12 22:35:55 KAMDesktop kernel: [  272.645061] hda-intel 0000:00:1b.0: 
azx_pcm_prepare: bufsize=0x10000, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645121] hda_codec_setup_stream: 
NID=0x10, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645122] hda_codec_setup_stream: 
NID=0x6, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645123] hda_codec_setup_stream: 
NID=0x2, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645124] hda_codec_setup_stream: 
NID=0x25, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645125] hda_codec_setup_stream: 
NID=0x3, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645125] hda_codec_setup_stream: 
NID=0x4, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645126] hda_codec_setup_stream: 
NID=0x5, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645137] hda-intel 0000:00:1b.0: 
azx_pcm_prepare: bufsize=0x10000, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645183] hda_codec_setup_stream: 
NID=0x10, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645184] hda_codec_setup_stream: 
NID=0x6, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645184] hda_codec_setup_stream: 
NID=0x2, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645185] hda_codec_setup_stream: 
NID=0x25, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645186] hda_codec_setup_stream: 
NID=0x3, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645187] hda_codec_setup_stream: 
NID=0x4, stream=0x8, channel=0, format=0x31
Aug 12 22:35:55 KAMDesktop kernel: [  272.645187] hda_codec_setup_stream: 
NID=0x5, stream=0x8, channel=0, format=0x31
