From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: snd-usb-midi, midi input, oss, oops!
Date: Mon, 16 Sep 2002 16:13:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209162313.QAA04893@cmn29.stanford.edu>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some notes on my latest experiences with usb midi (using a
MidiSport 2x2). This is with 2.4.20-pre4 + lowlat + preempt +
capabilities + acpi on a Sony GRX laptop, using alsa cvs from
Friday (with a patch to undo the latest api changes).

There are a couple of issues I have found:
a) midi input does not work.
b) it is possible (by doing things I should not be doing :-)
   to generate a kernel oops.

So, starting from a cold reboot I start alsa with the internal
intel-8x0 soundcard and no additional configuration in
modules.conf for the usb midi interface (except for an
appropriate value in snd_cards_limit). The audio driver for
the internal card starts fine.

After the reboot is done I conect the MidiSport 2x2 usb MIDI
interface. Hotplug recognizes the card, fxload loads the
firmware, the interface disconnects and reconnects, hotplug
recognizes that and loads snd-usb-audio (both "audio" and
"usb-midi" have been blacklisted). And that's it. With no
extra configuration snd-usb-audio is not automatically loading
snd-usb-midi (bug?). So I go ahead and load snd-usb-midi by
hand.

cat /proc/asound/devices shows two cards, the second one with
two midi interfaces. Lsmod shows all devices loaded.

I start pd -mididev 2 (uses oss emulation for midi on card 2).
There is a test panel that lets me check audio and midi i/o. I
click on Midi OUT and I can see the midi out LED in the
MidiSport blinking. Sending midi from a keyboard makes the
Midi IN LED blink (so the midi bytes are getting to the
interface) but I see no activity in the program (which should
be showing the midi bytes being received). Checking
/proc/asound/card1/midi0 I can see that Output 0 has a
non-zero value of "Tx bytes", but Input O has received
nothing. Same with Muse which uses the native alsa interface.

So everything seems to indicate things are working but
nothing is received by the programs and alsa.

So I say, let's try the oss drivers.

I unload all the alsa modules related with the second card
(which is the MidiSport). After that I load both "audio" and
"usb-midi", they say they recognize the card and they set up
two interfaces, /dev/midi00 and /dev/midi01. Trying to use pd
gets the same results, output works, input does not.

Now I get curious and say, what if I load the alsa usb midi
modules? (I know I should not be doing this!) So I go ahead
and load snd-usb-audio and then snd-usb-midi, to my surprise
they load (I would imagine they would refuse to load because
the other driver is using the midi interface hardware):

Sep 16 15:42:06 nando kernel: snd-usb-midi: MIDIStreaming version 01.00
Sep 16 15:42:06 nando kernel: snd-usb-midi: detected 2 output jack(s) on endpoint 1
Sep 16 15:42:06 nando kernel: snd-usb-midi: detected 2 input jack(s) on endpoint 1
Sep 16 15:42:06 nando kernel: ALSA ../alsa-kernel/core/rawmidi.c:1425: unable  
to register OSS rawmidi device 1:0
Sep 16 15:42:06 nando kernel: snd-usb-midi: endpoint 1: created 2 output and 2  
input ports

Note that they cannot register the device (because usb-midi is
using it?) but the drivers stay loaded and seem to create the
endpoints. If I try to start pd things keep working (midi in
does not work, of course), but I get some errors (not
surprising):

Sep 16 15:42:48 nando kernel: usb-uhci.c: ENXIO c0008580, flags 0, urb  
deebaea0, burb defc3ce0
Sep 16 15:42:48 nando kernel: usbmidi: Cannot submit urb for MIDI-IN
Sep 16 15:43:31 nando kernel: usb-uhci.c: ENXIO c0008580, flags 0, urb  
deebaea0, burb defc3ce0
Sep 16 15:43:31 nando kernel: usbmidi: Cannot submit urb for MIDI-IN

So I unload all modules, both alsa and oss versions dealing
with the MidiSport. They unload cleanly.

The I load snd-usb-audio and snd-usb-midi _again_. They load.

If I start pd I get a kernel oops:

Sep 16 15:46:01 nando kernel: Unable to handle kernel paging request at  
virtual address 0c8d8e23
Sep 16 15:46:01 nando kernel: c011c078
Sep 16 15:46:01 nando kernel: *pde = 00000000
Sep 16 15:46:01 nando kernel: Oops: 0000
Sep 16 15:46:01 nando kernel: CPU:    0
Sep 16 15:46:01 nando kernel: EIP:    0010:[<c011c078>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 16 15:46:01 nando kernel: EFLAGS: 00010206
Sep 16 15:46:01 nando kernel: eax: de54a000   ebx: 00000001   ecx: 00000012    
edx: 0c8d8e0f
Sep 16 15:46:01 nando kernel: esi: da2ee1c0   edi: 00000002   ebp: 00000012    
esp: de54bee4
Sep 16 15:46:01 nando kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 15:46:01 nando kernel: Process pd (pid: 2095, stackpage=de54b000)
Sep 16 15:46:01 nando kernel: Stack: dabb5f80 e096053c 0c8d8e0f 00000000  
00000002 de54a000 ddff5d20 da5042a0
Sep 16 15:46:01 nando kernel:        de54a000 c0116bdd de10b005 00000006  
ca839d9c de54a000 da2ee1c0 df486de0
Sep 16 15:46:01 nando kernel:        00000000 c013c283 df486de0 da2ee1c0  
da2ee1c0 df486de0 00000000 c160b360
Sep 16 15:46:01 nando kernel: Call Trace:    [<e096053c>] [<c0116bdd>]  
[<c013c283>] [<c013ae36>] [<c013ad3d>]
Sep 16 15:46:01 nando kernel:   [<c014538e>] [<c013b075>] [<c0108adb>]
Sep 16 15:46:01 nando kernel: Code: f6 42 14 02 74 04 31 db eb 07 ff 42 10 83  
4a 14 18 b8 00 e0

>>EIP; c011c078 <try_inc_mod_count+18/50>   <=====
Trace; e096053c <[soundcore]soundcore_open+6c/1e0>
Trace; c0116bdd <do_page_fault+19d/4df>
Trace; c013c283 <chrdev_open+53/90>
Trace; c013ae36 <dentry_open+e6/190>
Trace; c013ad3d <filp_open+4d/60>
Trace; c014538e <getname+5e/a0>
Trace; c013b075 <sys_open+35/a0>
Trace; c0108adb <system_call+33/38>
Code;  c011c078 <try_inc_mod_count+18/50>
00000000 <_EIP>:
Code;  c011c078 <try_inc_mod_count+18/50>   <=====
   0:   f6 42 14 02               testb  $0x2,0x14(%edx)   <=====
Code;  c011c07c <try_inc_mod_count+1c/50>
   4:   74 04                     je     a <_EIP+0xa> c011c082  
<try_inc_mod_count+22/50>
Code;  c011c07e <try_inc_mod_count+1e/50>
   6:   31 db                     xor    %ebx,%ebx
Code;  c011c080 <try_inc_mod_count+20/50>
   8:   eb 07                     jmp    11 <_EIP+0x11> c011c089  
<try_inc_mod_count+29/50>
Code;  c011c082 <try_inc_mod_count+22/50>
   a:   ff 42 10                  incl   0x10(%edx)
Code;  c011c085 <try_inc_mod_count+25/50>
   d:   83 4a 14 18               orl    $0x18,0x14(%edx)
Code;  c011c089 <try_inc_mod_count+29/50>
  11:   b8 00 e0 00 00            mov    $0xe000,%eax

Is there anything else I could test?

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
