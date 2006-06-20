From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002174]: No sound at all using
	snd-hda-intel / alsa-1.0.11
Date: Tue, 20 Jun 2006 19:45:57 +0200
Message-ID: <976cceb5196c1f39baa5a5fea82d9515@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 75366171
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 19:45:57 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been set as DUPLICATE OF issue 0001957.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174> 
======================================================================
Reported By:                carllivitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2174
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2122_FC5smp
======================================================================
Date Submitted:             05-30-2006 17:11 CEST
Last Modified:              06-20-2006 19:45 CEST
======================================================================
Summary:                    No sound at all using snd-hda-intel / alsa-1.0.11
Description: 
On my new Toshiba Satellite Pro P100 laptop, I cannot get sound from the
speakers or headphone jack. It has never worked.

I've used the standard FC5 kernel and the updated kernel
(2.6.16-1.2122FC5smp) without success. 

I've downloaded and installed the alsa-*-1.0.11 drivers etc, but still no
sound. Everything is unmuted, alsamixer can turn the volume controls up
and down, KDE's kmix also works fine but still no sound. There are no
error messages in the syslog. 

I've also tried using the 'single_cmd=1' module loading option. 

I tried the CVS version of ALSA, but it didn't work with my kernel - there
were unresolved symbols that I couldn't resolve. I'm back to using the
1.0.11 version.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001957 HP dv8000t hda-intel codec not recognized
======================================================================

----------------------------------------------------------------------
 carllivitt - 06-04-06 23:37 
----------------------------------------------------------------------
Hi, has anyone got any information/hints/fixes/patches etc for this
problem?

Thanks
Carl

----------------------------------------------------------------------
 carllivitt - 06-12-06 21:51 
----------------------------------------------------------------------
An update - still stumped.

I've rolled my own kernel (2.6.16.20) and tried the snd-hda-intel drivers
that are included with the kernel - no luck. Still silence.

I've also tried the CVS build of alsa (dated today, 12th June 2006) and
they are similarly silent.

I've still got no sound! Help!

----------------------------------------------------------------------
 rlrevell - 06-12-06 22:03 
----------------------------------------------------------------------
Did you try the model options for your codec as described in
ALSA-Configuration.txt?

Also ALSA CVS is no longer updated - you have to use the Hg repository
(see alsa-devel archive for instructions)

----------------------------------------------------------------------
 carllivitt - 06-12-06 22:52 
----------------------------------------------------------------------
I've now got the latest hg build  - the modules are built and working
fine... except of course there is no sound ;)

How do I determine which model I have (other than trying each one in
turn)?

----------------------------------------------------------------------
 rlrevell - 06-12-06 22:54 
----------------------------------------------------------------------
Check /proc/asound/card0/codec* to find out which codec you have then try
all the models listed for that codec in the docs.  It's easy, just rmmod
snd-hda-intel and modprobe again with each model.

----------------------------------------------------------------------
 carllivitt - 06-12-06 23:10 
----------------------------------------------------------------------
Aha! Thankyou, but it still doesn't work. None of the module model options
worked.  I just tried each in turn, playing a sound after each.

I checked /proc/asound/card0/codec#0 and this is what it reported:

[root@localhost Documentation]# cat /proc/asound/card0/codec#0
Codec: Generic 14f1 ID 5047
Address: 0
Vendor Id: 0x14f15047
Subsystem Id: 0x1179ff31
Revision Id: 0x100000
Default PCM: rates 0x040, bits 0x02, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1e 0x1e]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x11 [Audio Output] wcaps 0x611: Stereo Digital
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x12 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
  Amp-In vals:  [0x8e 0x8e] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
  Connection: 6
     0x19 0x14 0x15* 0x1a 0x16 0x10
Node 0x13 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1e 0x1e]
  Pincap 0x081001c: OUT HP
  Pin Default 0xc3111010: [Both] Speaker at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 3
     0x19* 0x10 0x16
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x0833c: IN OUT HP
  Pin Default 0x03811011: [Jack] Line In at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 2
     0x19* 0x16
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x0833c: IN OUT HP
  Pin Default 0x03a11012: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 3
     0x1c 0x19* 0x16
Node 0x16 [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x0860: IN
  Pin Default 0x99330100: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
  Power: 0x0
Node 0x17 [Pin Complex] wcaps 0x400481: Stereo
  Pincap 0x08324: IN
  Pin Default 0xb7a00100: [Fixed] Mic at Oth Mobile-In
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x18 [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x21440100: [Jack] SPDIF Out at Sep Rear
    Conn = RCA, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
  Connection: 1
     0x11
Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals:  [0x07 0x07] [0x07 0x07] [0x80 0x80] [0x17 0x17]
  Power: 0x0
  Connection: 4
     0x10 0x1b 0x1a 0x16
Node 0x1a [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x1f, mute=0
  Amp-Out vals:  [0x00 0x00]
  Power: 0x0
  Connection: 3
     0x15* 0x14 0x17
Node 0x1b [Audio Selector] wcaps 0x300501: Stereo
  Power: 0x0
  Connection: 2
     0x14* 0x15
Node 0x1c [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x08314: OUT
  Pin Default 0x90100112: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 3
     0x1c 0x19* 0x16
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono


Any ideas???

----------------------------------------------------------------------
 rlrevell - 06-12-06 23:14 
----------------------------------------------------------------------
It's a driver bug, apparently your codec is not supported.  You'll have to
wait for a fix.

----------------------------------------------------------------------
 carllivitt - 06-12-06 23:29 
----------------------------------------------------------------------
Do I need to pass any details to anyone / anywhere or will it be picked up
from here?

----------------------------------------------------------------------
 rlrevell - 06-12-06 23:35 
----------------------------------------------------------------------
No, you've provided enough info.

----------------------------------------------------------------------
 carllivitt - 06-12-06 23:49 
----------------------------------------------------------------------
Ok, thanks for all your help. What's the best way for me to find out when a
patch has been worked out... or will someone just post here?

----------------------------------------------------------------------
 rlrevell - 06-12-06 23:58 
----------------------------------------------------------------------
When it's fixed someone will update this bug report.

----------------------------------------------------------------------
 godeater - 06-13-06 15:33 
----------------------------------------------------------------------
An lspci -nv is quite useful in determining the subsystem id. If you can
just cut out the bit referring to your sound card it would reduce the
amount of hunting through that we'd have to do as well (00:1b.0)

----------------------------------------------------------------------
 rlrevell - 06-13-06 18:13 
----------------------------------------------------------------------
Please attach the lspci -nv output - don't post it inline.

----------------------------------------------------------------------
 jlpedrosa - 06-13-06 18:53 
----------------------------------------------------------------------
do you get any strange message from sound module in dmseg? 
I have a very similar hardware and i have the same problem..

mine says: Unknow model for ALC861, trying auto-probe from BIOS...

and i don't get master volume in alsamixer or kmixer...
but mi mic works perpectly amarok don't crashes (just dont sounds but
reproduces it)... maybe it the same issue..
it's opened here also #0002335

----------------------------------------------------------------------
 rlrevell - 06-13-06 18:58 
----------------------------------------------------------------------
jlpedrosa, I do not see an issue #2335 in the ALSA bug tracker.

Did you try all the models for ALC861 listed in ALSA-Configuration.txt?

        ALC861  
          3stack        3-jack  
          3stack-dig    3-jack with SPDIF I/O
          6stack-dig    6-jack with SPDIF I/O
          auto          auto-config reading BIOS (default)

----------------------------------------------------------------------
 jlpedrosa - 06-13-06 19:17 
----------------------------------------------------------------------
hummm sorry... it was 0002035. yes i tried those three.. also i opened a
driver i saw... and tried model_last.. but none of them working..
i'm on suse 10.1 wich i think uses... 11(rc4), but i tried the last from
alsa

lspci gives exactly the same line (maybe with -v won't be the same).

sorry for the mistake

----------------------------------------------------------------------
 carllivitt - 06-14-06 10:12 
----------------------------------------------------------------------
I've uploaded the soundcard portion of lspci -nv. The output is copied here
for reference:

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1179:ff31
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

----------------------------------------------------------------------
 carllivitt - 06-14-06 10:21 
----------------------------------------------------------------------
I've uploaded the contents of the file /proc/asound/card0/codec#0 as a file
called codec0.txt.

----------------------------------------------------------------------
 jlpedrosa - 06-14-06 16:13 
----------------------------------------------------------------------
i used to know english... 

Here's mine.... the subsystem insn't the same. I don't know if its the
same ALCXXX... Maybe it's related to #2035...

i cheked the BIOS update... but were only related to Booting from lan and
adding support to celeron... so I din't update

in realtek there are the pin and signals diagrams for alc861...

00:1b.0 Class 0403: 8086:27d8 (rev 02)
        Subsystem: 1584:9072
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at fe0f8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [70] Express Unknown type IRQ 0


Hope it's useful...
(if somebody need more info or testing just mailme jlpedrosa at gmail)
Jose Luis Pedrosa



----------------------------------------------------------------------
 carllivitt - 06-17-06 19:51 
----------------------------------------------------------------------
Well, it's seems like this has stalled. I'm quite willing to dive in and
have a go at sorting it if somebody can offer guidance. I'm very familiar
with Linux, have done some kernel dev before (designed and coded a rootkit
about 4 years ago) and know C very well.

Any offers of help of where to start?

Thanks, 
Carl

----------------------------------------------------------------------
 rlrevell - 06-17-06 19:57 
----------------------------------------------------------------------
Um, 3 days without an update is not exactly "stalled".

As far as next steps, it's hard - often the problem is lack of hardware
information.  Read the ALSA source code and alsa-devel archives.  Maybe
you can create a test model for your soundcard.

----------------------------------------------------------------------
 jlpedrosa - 06-18-06 12:44 
----------------------------------------------------------------------
Hi again...

if the problem is the same of 2035, from the ALC861, in realtek there is a
very complete hardware specifications, with pin and signal diagrams. I
don't know if it said in english.. but here it goes.. "chronograms" and a
lot of documentation...

http://www.realtek.com.tw/downloads/downloads1-3.aspx?Keyword=861

if anyone needs to do some testing i offer my computer.

(Wanna hear music!!) :)

----------------------------------------------------------------------
 fatman - 06-19-06 08:42 
----------------------------------------------------------------------
Hi there

I'm having the same problem with Intel HDA sound card in Toshiba Satellite
P100. I would like to add that if you pass acpi=off to the kernel you can
hear music but it's silent.

----------------------------------------------------------------------
 jlpedrosa - 06-19-06 13:49 
----------------------------------------------------------------------
humm....

I'm sorry but i don't understand hear music, but it's silent....

Right know i'm gonna trie

i'll be back :)

I'm back.

It didn't worked for me.. i booted with acpi=off and doesent emit any
sound.

thanks anyway



----------------------------------------------------------------------
 carllivitt - 06-20-06 11:04 
----------------------------------------------------------------------
jlpedrosa: I think your computer has a different chipset and is confusing
things in this bug report.

fatman: You have the same laptop as me - good! I don't understand "if you
pass acpi=off to the kernel you can hear music but it's silent." Hmm, you
can hear music but you can't...? Please explain!

----------------------------------------------------------------------
 fatman - 06-20-06 11:21 
----------------------------------------------------------------------
I'm sorry for misunderstanding - I was tired. I ment that there is sound
but it's hardly audible. In alsa mixer everything is at maximum level.
Passing pciacpi=off makes nothing, only acpi=off helps at all. If you do
some google search you should found a topic on Ubuntu group AFAIR that
it's a problem with kernel IRQ routing. 

That's great that you have P100 - there is few people having P100 with
Linux onboard. Feel free to ask me for help and testing.
I'm using Gentoo with latest vanilla kernel 2.6.17

----------------------------------------------------------------------
 legoguy - 06-20-06 17:38 
----------------------------------------------------------------------
FYI this issue was already noted in bug #1957, but didn't get this far in
discussions. Different laptop, same chip and codec. Hoping to see some
progress on this.

----------------------------------------------------------------------
 tiwai - 06-20-06 19:38 
----------------------------------------------------------------------
It's a conexant codec chip and we have no datasheet for this chip at all.
Thus it's hard to implement properly if the auto-detection code doesn't
work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 17:11 carllivitt     New Issue                                    
05-30-06 17:11 carllivitt     Distribution              => Fedora Core 5   
05-30-06 17:11 carllivitt     Kernel Version            => 2.6.16-1.2122_FC5smp
06-04-06 23:36 carllivitt     Issue Monitored: carllivitt                    
06-04-06 23:37 carllivitt     Note Added: 0010065                          
06-12-06 21:51 carllivitt     Note Added: 0010174                          
06-12-06 22:03 rlrevell       Note Added: 0010175                          
06-12-06 22:52 carllivitt     Note Added: 0010176                          
06-12-06 22:54 rlrevell       Note Added: 0010177                          
06-12-06 23:10 carllivitt     Note Added: 0010178                          
06-12-06 23:14 rlrevell       Note Added: 0010179                          
06-12-06 23:29 carllivitt     Note Added: 0010180                          
06-12-06 23:35 rlrevell       Note Added: 0010181                          
06-12-06 23:49 carllivitt     Note Added: 0010182                          
06-12-06 23:58 rlrevell       Note Added: 0010183                          
06-13-06 15:33 godeater       Note Added: 0010193                          
06-13-06 18:13 rlrevell       Note Added: 0010198                          
06-13-06 18:53 jlpedrosa      Note Added: 0010199                          
06-13-06 18:58 rlrevell       Note Added: 0010200                          
06-13-06 19:17 jlpedrosa      Note Added: 0010202                          
06-14-06 10:11 carllivitt     File Added: lspci-nv.txt                     
06-14-06 10:12 carllivitt     Note Added: 0010207                          
06-14-06 10:21 carllivitt     File Added: codec0.txt                       
06-14-06 10:21 carllivitt     Note Added: 0010208                          
06-14-06 13:17 jlpedrosa      Note Added: 0010210                          
06-14-06 16:13 jlpedrosa      Note Edited: 0010210                         
06-17-06 19:51 carllivitt     Note Added: 0010288                          
06-17-06 19:57 rlrevell       Note Added: 0010289                          
06-18-06 12:44 jlpedrosa      Note Added: 0010299                          
06-19-06 08:42 fatman         Note Added: 0010306                          
06-19-06 13:36 jlpedrosa      Note Added: 0010308                          
06-19-06 13:49 jlpedrosa      Note Edited: 0010308                         
06-20-06 11:04 carllivitt     Note Added: 0010332                          
06-20-06 11:21 fatman         Note Added: 0010333                          
06-20-06 17:38 legoguy        Note Added: 0010338                          
06-20-06 17:39 legoguy        Issue Monitored: legoguy                     
06-20-06 19:38 tiwai          Note Added: 0010341                          
06-20-06 19:45 rlrevell       Relationship added       duplicate of 0001957
======================================================================
