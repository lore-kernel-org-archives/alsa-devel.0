From: Kristian Amlie <kristian@amlie.name>
Subject: How to add a new MIDI device to the usbaudio driver
Date: Mon, 22 Aug 2011 12:52:32 +0200
Message-ID: <4E5234F0.8000502@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy8-pub.bluehost.com (oproxy8-pub.bluehost.com
	[69.89.22.20]) by alsa0.perex.cz (Postfix) with SMTP id 1187724555
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:52:47 +0200 (CEST)
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

I have just received a new MIDI instrument (Starr Labs Z7S) which is not
recognized by the kernel, and I'd like to add support for it. I'm hoping
that it uses a standard MIDI interface and it's just a matter of adding
the correct entry in the table of devices.

I have tried to add an entry to sound/usb/usbquirks.h
(sound/usb/quirks-table.h in later kernels), but so far I haven't
succeeded. Is there any documentation for how to do this, and which
options to use? Google hasn't really turned up anything...

-- 
Kristian
