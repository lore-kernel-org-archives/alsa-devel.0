From: Eran Guendelman <erang@stanford.edu>
Subject: Got microphone working with SigmaTel STAC 9221 A1 on a
	Dell XPS M1210
Date: Sat, 09 Jun 2007 16:37:11 -0700
Message-ID: <466B39A7.3000905@stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101090206010008010402"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agp.stanford.edu (agp.Stanford.EDU [171.67.73.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BC8F2460B
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Jun 2007 01:37:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080101090206010008010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I installed SuSE 10.2 on my new XPS M1210 laptop and found that the 
microphone was not working (headphones and internal speakers worked 
fine).  I eventually got it working, and wanted to write an email 
describing how I did this.

The two main important steps (which I will describe in more detail 
below) were:
- Changing the default pin configurations ref922x_pin_configs in 
patch_sigmatel.c to values that were based on the windows driver's INI 
file but with one important tweak.
- Running the driver using the "model=ref" parameter so that the above 
modified pin configurations are used.

Note that it could be that my solution is overkill and there's actually 
a way to get this working with the unmodified alsa drivers...  But I did 
not find any such solutions (e.g. I've tried setting "model=ref", 
"model=3stack", "model=5stack", but none of those fixed the microphone). 
  In general, it seems that the solutions proposed on the internet to 
getting the SigmaTel codec working are very dependent on the exact type 
of system you've got...  So this will likely only work for a Dell XPS 
M1210.  Here is some more system info:

"lspci -v" gives this as my audio card:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
	Subsystem: Dell Unknown device 01d7
	Flags: bus master, fast devsel, latency 0, IRQ 233
	Memory at efffc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

My card uses the snd_hda_intel module, and the codec type (given by "cat 
/proc/asound/card0/codec#0") gives this information at the top:

Codec: SigmaTel STAC9221 A1
Address: 0
Vendor Id: 0x83847680
Subsystem Id: 0x102801d7
Revision Id: 0x103601

So here's what I did (taking many days and many wrong steps before 
arriving at this solution):

- I have a dual-boot system and installed the official DELL drivers for 
the sound card in Windows XP.  My goal was to find which INI file 
corresponded to my installed sound card, so I did the following:

	- Using Windows device manager, I looked at the properties for the 
SigmaTel codec driver and found that one of the property items had a 
string that included the substring

	VEN_8384&DEV_7680&SUBSYS_102801D7

	- The self-extracting DELL driver extracted files into 
c:\dell\drivers\r122161, and in the wdm subdirectory I searched for the 
above string and found that the files 92xxM.INI, Sthda.ini, and 
sthda64.ini all contained the above string and also had the suffix 
=92xxM8-2.ini appended to it.  This led me to deduce that the relevant 
file was 92xxm8-2.ini

	- This is an excerpt from 92xxm8-2.ini:

[HKR\Settings\pin\0A]
CfgDflt = dword: 0x0221121E
AltCfg = hex: 20,12,11,02
Action = hex: 80,00,87,00,81,0D
[HKR\Settings\pin\0B]
CfgDflt = dword: 0x408103FF
[HKR\Settings\pin\0C]
CfgDflt = dword: 0x0281123E
AltCfg = hex: 22,12,11,02,30,12,A1,02
Bias = hex: FF,04,02
Action: hex: 0A, 0C
[HKR\Settings\pin\0D]
CfgDflt = dword: 0x90100310
[HKR\Settings\pin\0E]
CfgDflt = dword: 0x408003F1
[HKR\Settings\pin\0F]
CfgDflt = dword: 0x0221122F
AltCfg = hex: 21,12,11,02
Action = hex: 80,00,87,00,81,0D
[HKR\Settings\pin\10]
CfgDflt = dword: 0x03451340
[HKR\Settings\pin\11]
CfgDflt = dword: 0x40C003F2
[HKR\Settings\pin\15]
CfgDflt = dword: 0x50A003F3
[HKR\Settings\pin\1B]
CfgDflt = dword: 0x405003F4

	- This will be useful later...  Now back to linux.

- I downloaded latest alsa-driver package (version 1.0.14).

- I edited alsa-kernel/pci/hda/patch_sigmatel.c, and replaced the 
contents of the ref922x_pin_configs array with the default pin 
configurations found in the INI file above WITH ONE IMPORTANT TWEAK. 
Specifically, this is my new array:

static unsigned int ref922x_pin_configs[10] = {
     0x0221121E, 0x408103FF, 0x02A1123E, 0x90100310,
     0x408003F1, 0x0221122F, 0x03451340, 0x40C003F2,
     0x50A003F3, 0x405003F4
};

- If you compare these numbers to the CfgDflt values from the Windows 
INI file above, you'll see that they match except that for the third 
value, instead of
	0x281123E
I use
	0x2A1123E

Here's why:  I figured out that pin complex 0x0c was my microphone jack 
(the right-most of the three jacks in the front of my laptop).  The 
0x281123E configuration indicates a "Line In at Ext Front" jack... 
Indeed, this jack can serve as a line in or mic in or even I believe as 
output to rear speakers.  But designating it as Line In by default seems 
to confuse the patch_sigmatel.c routines that set up the codec...  They 
assume it's just a line in jack and do not mark it as potential 
microphone input.  Changing the 8 to an A in the value designates it as 
"Mic at Ext Front", so the codec recognizes it as the microphone input 
for the card.  What ends up happening is that as a microphone input, the 
Pin-ctls for the pin gets assigned to 0x24, whereas when it just thinks 
it's a Line In the Pin-ctls gets set to 0x20.  Both designate an input, 
but the 4 in 0x24 seems to also give it a Voltage Reference Signal which 
I guess is important for microphone inputs.  (I don't fully understand 
most of this stuff... I've just been reading up about the HD Audio specs 
over the last few days).

- Build and install drivers using
	"./configure --with-cards=hda-intel --with-sequencer=yes; make; make 
install"

- Make sure the snd_hda_intel gets loaded with model=ref option.  You 
need to specify the ref model so that the pin configurations set up 
above are used.  Of course, the right way to do this would be to make a 
whole new model, but I didn't bother doing that in my quick hack. 
Anyway, in SuSE 10.2 you can set the model through YaST, or you can 
manually edit /etc/modprobe.d/sound and make sure model=ref is listed as 
one of the options in the "options snd-hda-intel  . . ." line

- Reset sound drivers.  (Best to just reset computer, but on SuSE 10.2 
it usually works if I do "/etc/init.d/alsasound reset")

- And that's basically it...  In the mixer (e.g. alsamixer) it's 
important to make sure the Capture channel has "CAPTUR" on and that it's 
at a high value, and that the Mux is at its max too.  It does not allow 
me to change "Input Source", but that's fine because the above 
essentially hard codes it to be Front Mic which is what I wanted.

I've attached the contents of /proc/asound/card0/codec#0 in its good 
(mic working) state.  The final path is
	0x0c (mic)
	-> 0x12 (audio selector, stereo amp-out; Mux in the mixer)
	-> 0x17 (audio selector, stereo amp-in; Capture in the mixer)
	-> 0x06 (audio input)

After searching on the internet, reading about HD Audio, and poking 
around the driver code, I do have a number of lingering questions I 
would be happy to have answered:

- Why does patch_sigmatel.c "fix" mux capture levels to 2?  The Mux 
(0x12) ends up in the path from the mic in jack to the audio in, so is 
it supposed to act as a Mic Boost or something?

- I noticed my headphone jacks (0x0a, 0x0f) have Pin-ctls set at 0xc0 
which is OUT HP (i.e. uses a low impedance amplifier for headphone 
output).  Would it damage my sound card or speakers if I connected these 
jacks to powered speakers or to an audio receiver (i.e. more 
traditionally connected to a Line Out)?

- Does the snd_hda_intel driver currently (or will it eventually) 
support dynamic switching so I can switch from the Mic In to Line In or 
to Rear Speakers Out, etc, just like in the Windows driver?

- Some solutions on the internet talked about creating an .asoundrc file 
to get the codec working...  I don't understand what that file is for 
and whether I need to tweak it at all...  But since I have a working 
solution without the file I guess I'm fine?

Thanks,

Eran.

P.S. Not subscribed, so please respond by email...


--------------080101090206010008010402
Content-Type: text/plain;
 name="codec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="codec"

Codec: SigmaTel STAC9221 A1
Address: 0
Vendor Id: 0x83847680
Subsystem Id: 0x102801d7
Revision Id: 0x103601
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6b 0x6b]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x66 0x6d]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x0221121e: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x408103ff: [N/A] Line In at Ext N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x02a1123e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x90100310: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN Detect
  Pin Default 0x408003f1: [N/A] Line In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x0221122f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x03451340: [Jack] SPDIF Out at Ext Left
    Conn = Optical, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40c003f2: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x02 0x02]
  Connection: 7
     0x0e 0x15 0x0f 0x0b 0x0c* 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15 0x0f 0x0b 0x0c* 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x50a003f3: [N/A] Mic at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0e 0x0e]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x405003f4: [N/A] Digital Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x1a

--------------080101090206010008010402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080101090206010008010402--
