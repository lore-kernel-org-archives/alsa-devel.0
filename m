From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: bugs in usb midi alsa code?
Date: Tue, 5 Nov 2002 12:22:42 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211051140430.21282-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA13872
	for <alsa-devel@alsa-project.org>; Tue, 5 Nov 2002 21:23:22 +0100
Received: from cmn37.stanford.edu (cmn37.stanford.edu [171.64.197.186])
	by cm-mail.stanford.edu (8.11.6/8.11.6) with ESMTP id gA5KMhL21217
	for <alsa-devel@alsa-project.org>; Tue, 5 Nov 2002 12:22:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by cmn37.stanford.edu (8.11.6/8.11.6) with ESMTP id gA5KMh323260
	for <alsa-devel@alsa-project.org>; Tue, 5 Nov 2002 12:22:43 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The MIDI interface I'm using is a Midisport 2x2 (same results with a 1x1).

It works fine with alsa cvs of 2002-08-20, has problems with alsa cvs of
2002-10-28.

This is a summary of what I have found so far. 

OSS emulation (raw midi interface):
  OSS programs using the raw midi interface emulation (I'm using pd) can't 
  see both midi ports in the oss emulation world. They only see the first
  port. This is confirmed by this:

  cat /proc/asound/oss/devices
   18: [1- 2]: raw midi

  Midi input and output works fine on the first port, byte counts can be 
  read through cat /proc/asound/card1/midi0.

  On the older alsa version the two interfaces show up:
  cat /proc/asound/oss/devices
   34: [2- 2]: raw midi
   45: [2-13]: raw midi

ALSA:
  input does not seem to work at all. I'm using the Muse MIDI sequencer, 
  with  the older alsa version it works fine (input), with the newer alsa 
  version it does not record midi input at all. Output works fine on both 
  alsa versions. 

  The input byte counters in /proc/asound/card1/midi0 do not increment. 

  cat /proc/asound/devices shows only one raw midi interface. This is on 
  a two port device (but Muse lets me select either port). On the older 
  alsa two devices show up on the listing. 

Has someone out there tested a similar configuration?
-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
