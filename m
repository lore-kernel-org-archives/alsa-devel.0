From: Roger E Critchlow Jr <rec@elf.org>
Subject: toshiba tecra + ymfpci doesn't work
Date: Mon, 25 Feb 2002 12:57:11 -0700
Message-ID: <15482.38679.932097.408551@elf2.elf.org>
References: <15470.43840.123238.223477@elf2.elf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from scaup.prod.itd.earthlink.net (scaup.mail.pas.earthlink.net [207.217.120.49])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA02825
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2002 22:41:55 +0100
Received: from sdn-ar-003nmalbup118.dialsprint.net ([158.252.153.78] helo=elf6.elf.org)
	by scaup.prod.itd.earthlink.net with esmtp (Exim 3.33 #1)
	id 16fSsP-0007Sr-00
	for alsa-devel@alsa-project.org; Mon, 25 Feb 2002 13:41:42 -0800
Received: from elf2.elf.org (elf2.elf.org [192.168.1.2])
	by elf6.elf.org (8.11.6/8.11.6) with ESMTP id g1PJsSI18175
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2002 12:54:28 -0700
In-Reply-To: <15470.43840.123238.223477@elf2.elf.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello again,

I'm still trying to figure why this doesn't work.  In the past ten
days I've discovered that:

  1) Alsamixer will "mute" channels which have no playback switch,
which explains how the channels mysteriously revert to unmuted state.

  2) By turning both ADC channels down to zero level, I am able to
hear a faint click when pcm playback starts and a moderate crunch when
playback terminates.  The series of scratching sounds emitted when the
driver loads is much longer with these mixer settings.  The primary
ADC channel gets very noisy at low levels going up or down.  The
secondary ADC emits a loud click as it turns off.  Nothing is audible
on headphones when either ADC channel has any level enabled.

I still wonder whether the fact that channels are unmuted at coldstart
indicates a driver problem.

My current suspicion is that the ymfpci driver has been rewritten to
allow for 4-channel playback in a way that fails to detect the typical
laptop configuration, which is that only one codec is connected when
the laptop is not docked.

Does this make any sense?

The mixer reports itself as "Asahi Kasei (5)", is this an abbreviation
for the ak4545?

Still hoping to get some help with this,

-- rec --

Roger E Critchlow Jr writes:
 > Hi --
 > 
 >   The ymfpci driver in the current alsa-cvs release isn't working on
 > my laptop and hasn't been working since at least December.  The OSS
 > driver in kernel 2.4.9 does work and the driver in alsa-driver-0.5.12a
 > does work.  I'm currently running kernel 2.4.17 with patches on top of
 > Redhat 7.2.
 > 
 >   There aren't any error messages generated during startup or at any
 > other time, the device appears to start up and appears to work but it
 > doesn't generate any sound:
 > 
 > Feb 16 09:35:40 elf2 alsasound: Starting sound driver: snd-ymfpci 
 > Feb 16 09:35:40 elf2 kernel: ALSA ../../alsa-kernel/pci/ymfpci/ymfpci.c:130: MPU401 supported on 0xff20
 > Feb 16 09:35:40 elf2 kernel: PCI: Found IRQ 11 for device 00:0c.0
 > Feb 16 09:35:40 elf2 kernel: PCI: Sharing IRQ 11 with 00:05.2
 > Feb 16 09:35:40 elf2 alsasound: done
 > 
 >   When the sound driver loads during a normal multiuser boot, there is
 > a sequence of scratching sounds from the builtin speakers, but that's
 > the last noise that the driver makes.
 > 
 >   If I boot up single user, from a warm or cold start, modprobe the
 > driver, and save the alsa state with alsactl, the following controls
 > are not in the default mute state, which suggests that the driver is 
 > confused about the hardware it's controlling:
 > 
 > 	control.25 {
 > 		comment.access 'read write'
 > 		comment.type BOOLEAN
 > 		iface MIXER
 > 		name 'Capture Switch'
 > 		value true
 > 	}
 > 	control.34 {
 > 		comment.access 'read write'
 > 		comment.type INTEGER
 > 		comment.range '0 - 16383'
 > 		iface MIXER
 > 		name 'Wave Playback Volume'
 > 		value.0 16383
 > 		value.1 16383
 > 	}
 > 	control.36 {
 > 		comment.access 'read write'
 > 		comment.type INTEGER
 > 		comment.range '0 - 16383'
 > 		iface MIXER
 > 		name 'Digital Capture Volume'
 > 		value.0 16383
 > 		value.1 16383
 > 	}
 > 	control.37 {
 > 		comment.access 'read write'
 > 		comment.type INTEGER
 > 		comment.range '0 - 16383'
 > 		iface MIXER
 > 		name 'Digital Capture Volume'
 > 		index 1
 > 		value.0 16383
 > 		value.1 16383
 > 	}
 > 	control.39 {
 > 		comment.access 'read write'
 > 		comment.type INTEGER
 > 		comment.range '0 - 16383'
 > 		iface MIXER
 > 		name 'ADC Capture Volume'
 > 		value.0 16383
 > 		value.1 16383
 > 	}
 > 	control.42 {
 > 		comment.access 'read write'
 > 		comment.type INTEGER
 > 		comment.range '0 - 16383'
 > 		iface MIXER
 > 		name 'IEC958 AC97 Playback Volume'
 > 		value.0 16383
 > 		value.1 16383
 > 	}
 > 
 > Several controls, including the ones listed above, cannot be adjusted
 > successfully in alsamixer or oss based mixers: the mixer reports that
 > it has muted the channel or changed the level, but the mute state or
 > channel level is back to its original value when you start the mixer
 > up again.
 > 
 > -- rec --
 > 
 > _______________________________________________
 > Alsa-devel mailing list
 > Alsa-devel@lists.sourceforge.net
 > https://lists.sourceforge.net/lists/listinfo/alsa-devel

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
