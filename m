From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: X-Fi support in ALSA.
Date: Tue, 11 Mar 2008 21:24:15 +0000
Message-ID: <47D6F87F.6080809@superbug.co.uk>
References: <47D59820.9020106@superbug.co.uk> <s5hlk4pb2qf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040902050307020601020507"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-36.mail.demon.net (anchor-post-36.mail.demon.net
	[194.217.242.86])
	by alsa0.perex.cz (Postfix) with ESMTP id 3851C243AC
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 22:24:17 +0100 (CET)
In-Reply-To: <s5hlk4pb2qf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040902050307020601020507
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Mon, 10 Mar 2008 20:20:48 +0000,
> James Courtier-Dutton wrote:
>> Hi,
>>
>> I have now had a chance to read some of the specs of the X-Fi cards. 
>> aka. emu20k1.
>> It turns out that some of the X-Fi cards have a compatibility mode.
>> By default, they boot up in compatibility mode.
>> The interesting point is that this "compatibility mode" is in fact the 
>> intel-HD standard so could use the intel-hda driver.
>> For one X-Fi card with IDs:
>> Device 1102:0009 Subsystem: 1102:0010
>> works a bit with the ALSA hda-intel driver.
>> So far, the off the shelf hda-intel driver, with simple PCIs adjustment, 
>> works for the above card, but only sound capture works so far, so 
>> probably some quirk would be needed.
>> This compatibility mode works with the Windows Vista UAA drivers.
> 
> Could you show /proc/asound/card*/codec#* contents for HD-audio mode?
> 
> 
> Takashi

See attached


--------------040902050307020601020507
Content-Type: text/plain;
 name="ca0110-codec.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ca0110-codec.txt"

# Codec: Generic 1102 ID a
# Address: 1
# Vendor Id: 0x1102000a
# Subsystem Id: 0x1462c320
# Revision Id: 0x100000
# No Modem Function Group found
# Default PCM:
#    rates [0x160]: 44100 48000 96000
#    bits [0xa]: 16 24
#    formats [0x1]: PCM
# Default Amp-In caps: ofs=0x67, nsteps=0x73, stepsize=0x01, mute=0
# Default Amp-Out caps: ofs=0x67, nsteps=0x67, stepsize=0x01, mute=0
# GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
# Node 0x02 [Audio Output] wcaps 0x5: Stereo Amp-Out
#  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-Out vals:  [0x53 0x53]
#  Converter: stream=0, channel=0
# Node 0x03 [Audio Output] wcaps 0x5: Stereo Amp-Out
#  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-Out vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
# Node 0x04 [Audio Output] wcaps 0x5: Stereo Amp-Out
#  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-Out vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
# Node 0x05 [Audio Output] wcaps 0x5: Stereo Amp-Out
#  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-Out vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
# Node 0x06 [Audio Output] wcaps 0x5: Stereo Amp-Out
#  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-Out vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
# Node 0x07 [Audio Output] wcaps 0x205: Stereo Digital Amp-Out
#  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-Out vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
#  Digital:
#  Digital category: 0x0
# Node 0x08 [Audio Input] wcaps 0x100103: Stereo Amp-In
#  Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-In vals:  [0x0c 0x0c]
#  Converter: stream=0, channel=0
#  SDI-Select: 1
#  Connection: 1
#     0x10
# Node 0x09 [Audio Input] wcaps 0x10010b: Stereo Amp-In
#  Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-In vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
#  SDI-Select: 1
#  Connection: 1
#     0x11
# Node 0x0a [Audio Input] wcaps 0x100303: Stereo Digital Amp-In
#  Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
#  Amp-In vals:  [0x67 0x67]
#  Converter: stream=0, channel=0
#  SDI-Select: 1
#  Digital: Non-Audio Pro GenLevel
#  Digital category: 0x60
#  Connection: 1
#     0x13
# Node 0x0b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
#  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-Out vals:  [0x00 0x00]
#  Pincap 0x0814: OUT Detect
#  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
#    Conn = 1/8, Color = Green
#    DefAssociation = 0x1, Sequence = 0x0
#  Pin-ctls: 0x40: OUT
#  Unsolicited: tag=00, enabled=0
#  Connection: 1
#     0x02
# Node 0x0c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
#  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-Out vals:  [0x00 0x00]
#  Pincap 0x0814: OUT Detect
#  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
#    Conn = 1/8, Color = Orange
#    DefAssociation = 0x1, Sequence = 0x1
#  Pin-ctls: 0xc0: OUT HP
#  Unsolicited: tag=00, enabled=0
#  Connection: 1
#     0x03
# Node 0x0d [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
#  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-Out vals:  [0x00 0x00]
#  Pincap 0x0814: OUT Detect
#  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
#    Conn = 1/8, Color = Black
#    DefAssociation = 0x1, Sequence = 0x2
#  Pin-ctls: 0xc0: OUT HP
#  Unsolicited: tag=00, enabled=0
#  Connection: 1
#     0x04
# Node 0x0e [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
#  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-Out vals:  [0x00 0x00]
#  Pincap 0x0814: OUT Detect
#  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
#    Conn = 1/8, Color = Grey
#    DefAssociation = 0x1, Sequence = 0x4
#  Pin-ctls: 0xc0: OUT HP
#  Unsolicited: tag=00, enabled=0
#  Connection: 1
#     0x05
# Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
#  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-Out vals:  [0x00 0x00]
#  Pincap 0x081c: OUT HP Detect
#  Pin Default 0x02214020: [Jack] HP Out at Ext Front
#    Conn = 1/8, Color = Green
#    DefAssociation = 0x2, Sequence = 0x0
#  Pin-ctls: 0xc0: OUT HP
#  Unsolicited: tag=00, enabled=0
#  Connection: 1
#     0x06
# Node 0x10 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
#  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-In vals:
#  Pincap 0x0824: IN Detect
#  Pin Default 0x01813030: [Jack] Line In at Ext Rear
#    Conn = 1/8, Color = Blue
#    DefAssociation = 0x3, Sequence = 0x0
#  Pin-ctls: 0x20: IN
#  Unsolicited: tag=00, enabled=0
# Node 0x11 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
#  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-In vals:
#  Pincap 0x0824: IN Detect
#  Pin Default 0x02a19040: [Jack] Mic at Ext Front
#    Conn = 1/8, Color = Pink
#    DefAssociation = 0x4, Sequence = 0x0
#  Pin-ctls: 0xa0: IN HP
#  Unsolicited: tag=00, enabled=0
# Node 0x12 [Pin Complex] wcaps 0x40038d: Stereo Digital Amp-Out
#  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-Out vals:  [0x00 0x00]
#  Pincap 0x0810: OUT
#  Pin Default 0x01452150: [Jack] SPDIF Out at Ext Rear
#    Conn = Optical, Color = Grey
#    DefAssociation = 0x5, Sequence = 0x0
#    Misc = NO_PRESENCE
#  Pin-ctls: 0xc0: OUT HP
#  Unsolicited: tag=00, enabled=0
#  Connection: 1
#     0x07
# Node 0x13 [Pin Complex] wcaps 0x40028b: Stereo Digital Amp-In
#  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
#  Amp-In vals:
#  Pincap 0x0820: IN
#  Pin Default 0x01c51160: [Jack] SPDIF In at Ext Rear
#    Conn = Optical, Color = Black
#    DefAssociation = 0x6, Sequence = 0x0
#    Misc = NO_PRESENCE
#  Pin-ctls: 0xa0: IN HP
#  Unsolicited: tag=00, enabled=0
# Node 0x14 [Vendor Defined Widget] wcaps 0xf00080: Mono
#  Unsolicited: tag=00, enabled=0



--------------040902050307020601020507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040902050307020601020507--
