From: Steven Zakulec <spzakulec@mail.widener.edu>
Subject: [HDA-Intel/ALC268] no sound
Date: Wed, 27 Jun 2007 17:34:15 -0400 (EDT)
Message-ID: <89157807.1182980055151.JavaMail.root@ccprodapp22>
Reply-To: Steven Zakulec <spzakulec@mail.widener.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ccprodapp22.campuscruiser.com (email.campuscruiser.com
	[216.35.68.59]) by alsa0.perex.cz (Postfix) with ESMTP id 09C8C24532
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 23:34:26 +0200 (CEST)
Received: from ccprodapp22 (localhost [127.0.0.1])
	by ccprodapp22.campuscruiser.com (8.13.1/8.13.1) with ESMTP id
	l5RLYFPS010655
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 17:34:25 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Continued from this thread: http://mailman.alsa-project.org/pipermail/alsa-devel/2007-June/001459.html)

I've included the result of alsactl -f somefile store.  I thought it got sent to the list earlier, but apparently not. Below this I also added the alsa things from dmesg.

state.Intel {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 64'
                iface MIXER
                name 'Front Playback Volume'
                value.0 57
                value.1 57
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Front Playback Switch'
                value.0 true
                value.1 true
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 64'
                iface MIXER
                name 'Headphone Playback Volume'
                value.0 63
                value.1 63
        }
        control.4 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Headphone Playback Switch'
                value.0 true
                value.1 true
        }
        control.5 {
                comment.access 'read write'
                comment.type INTEGER
               comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Capture Volume'
                value.0 1
                value.1 1
        }
        control.6 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 false
                value.1 false
        }
        control.7 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Capture Volume'
                index 1
                value.0 1
                value.1 1
        }
        control.8 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                index 1
                value.0 false
                value.1 false
        }
        control.9 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 'Front Mic'
                iface MIXER
                name 'Input Source'
                value Mic
        }
        control.10 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 'Front Mic'
                iface MIXER
                name 'Input Source'
                index 1
                value Mic
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Off-hook Switch'
                value false
        }
        control.12 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Caller ID Switch'
                value false
        }
        control.13 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                comment.tlv '0000000100000008ffffec1400000014'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 255
                value.1 255
        }
}
hda_codec: Unknown model for ALC268, trying auto-probe from BIOS...
[   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2339: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2343:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2347:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2355:    inputs: mic=0x19, fmic=0x18, line=0x0, fline=0x0, cd=0x0, aux=0x0
[   19.236000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:244: si3054: cannot initialize. EXT MID = 0000
[   19.244000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:256: Link Frame Detect(FDT) is not ready (line status: 0000)



                comment.count 2
:
