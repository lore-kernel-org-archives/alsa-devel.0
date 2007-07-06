From: Steven Zakulec <spzakulec@mail.widener.edu>
Subject: Re: [Fixed-Mostly] ALC268
Date: Fri, 6 Jul 2007 10:51:39 -0400 (EDT)
Message-ID: <28960558.1183733499339.JavaMail.root@ccprodapp10.campuscruiser.com>
Reply-To: Steven Zakulec <spzakulec@mail.widener.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_942_31449213.1183733499337"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ccprodapp10.campuscruiser.com (email.campuscruiser.com
	[216.35.68.59]) by alsa0.perex.cz (Postfix) with ESMTP id 7D97B245BB
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 16:51:40 +0200 (CEST)
Received: from ccprodapp10.campuscruiser.com (localhost.localdomain
	[127.0.0.1])
	by ccprodapp10.campuscruiser.com (8.13.1/8.13.1) with ESMTP id
	l66Epd5M022474
	for <alsa-devel@alsa-project.org>; Fri, 6 Jul 2007 10:51:39 -0400
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

------=_Part_942_31449213.1183733499337
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've found another issue: I've lost some mixer options now.  I've lost 1 capture source at least.  I've attached the result of alsactl -f somefile store from before sound worked and after.

---------------------------------------
Original E-mail
From: Steven Zakulec [spzakulec@mail.widener.edu]
Date: 07/06/2007 10:04 AM 
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] [Fixed-Mostly] ALC268

I was finally able to get sound working, thanks to the bugreport here: https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3104

What I did was get the patch_realtek.c from the bugreport, put it in alsa-kernel/pci/hda, and then re-build the driver (plus I re-built the lib, but probably not necessary).  I wasn't able to rmmod snd-hda-intel after the build finished, so I restarted the computer, and then it just worked.

Unfortunately, the headphone jack is not working.  The sound is only slightly, if at all, muted from the speakers when the headphones are plugged in.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



------=_Part_942_31449213.1183733499337
Content-Type: multipart/mixed;
	boundary="----=_Part_943_17512636.1183733499337"

------=_Part_943_17512636.1183733499337
Content-Type: application/octet-stream; name=somefile
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=somefile

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

------=_Part_943_17512636.1183733499337
Content-Type: application/octet-stream; name=somefile2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=somefile2

state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		iface MIXER
		name 'Front Playback Volume'
		value.0 56
		value.1 56
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
		value.0 30
		value.1 30
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
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Off-hook Switch'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Caller ID Switch'
		value false
	}
	control.10 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 137
		value.1 137
	}
}

------=_Part_943_17512636.1183733499337--

------=_Part_942_31449213.1183733499337
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_942_31449213.1183733499337--
