From: Panagiotis Papadakos <papadako@ics.forth.gr>
Subject: snd-hda-intel at Asus A6Va laptop
Date: Tue, 25 Oct 2005 19:07:51 +0300 (EET DST)
Message-ID: <Pine.GSO.4.58.0510251859280.20376@calliope>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailhost.ics.forth.gr (mailhost.ics.forth.gr [139.91.157.50])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8B9B0167
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 18:07:57 +0200 (MEST)
Received: from mailhost.ics.forth.gr (nemesis.ics.forth.gr [139.91.157.50])
	by mailhost.ics.forth.gr (8.12.10/ICS-FORTH/V10-Server-1.0) with SMTP id j9PG5r67008029
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 19:07:56 +0300 (EEST)
Received: (from ASSP-nospam [127.0.0.1])
 by mailhost.ics.forth.gr (SMSSMTP 4.1.0.19) with SMTP id M2005102519075113571
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 19:07:51 +0300
Received: from localhost (papadako@localhost)
	by calliope.ics.forth.gr (8.9.3/ICS-FORTH/V8.2.2C-INTNULL) with ESMTP id TAA23791
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 19:07:51 +0300 (EET DST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Using the default parameteres for the snd-hda-intel module
for my laptop, I could not get sound from the headphones, which
is in the same jack as the SPDIF. So I used the option model=z71v
to make it work. Here is the related info:

00:1b.0 Class 0403: 8086:2668 (rev 04)
        Subsystem: 1043:1173
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]


Regards
	Papadakos Panagiotis


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
