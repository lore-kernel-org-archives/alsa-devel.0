From: Clemens Ladisch <clemens@ladisch.de>
Subject: [ANNOUNCE] USB MIDI support for ALSA
Date: Mon, 13 May 2002 21:21:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CE01254.901318C3@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA11529
	for <alsa-devel@alsa-project.org>; Mon, 13 May 2002 21:21:59 +0200
Received: from mserv1.urz.uni-halle.de ([141.48.3.145] helo=mserv1)
	  by mailgate.uni-halle.de with esmtp (EXIM Version 3.35)
	  for <alsa-devel@alsa-project.org>
	  id 177LOP-00062U-00; Mon, 13 May 2002 21:21:57 +0200
Received: from conversion-daemon.mail.uni-halle.de by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 id <0GW200A01CGC1T@mail.uni-halle.de> for alsa-devel@alsa-project.org; Mon,
 13 May 2002 21:21:56 +0200 (MEST)
Received: from studcom.urz.uni-halle.de
 (studcom.urz.Uni-Halle.DE [141.48.3.19]) by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 with ESMTP id <0GW20036HDSKTV@mail.uni-halle.de> for
 alsa-devel@alsa-project.org; Mon, 13 May 2002 21:21:56 +0200 (MEST)
Received: from ladisch.de (ifiu23.informatik.Uni-Halle.DE [141.48.14.23])
	by studcom.urz.uni-halle.de (8.9.3 (PHNE_22672)/8.9.3)
 with ESMTP id VAA12186	for <alsa-devel@alsa-project.org>; Mon,
 13 May 2002 21:21:56 +0200 (METDST)
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

Hi,

I've written a daemon which connects the ALSA sequencer with the
usbdevfs device file of a USB MIDI device. You can get it at
<http://www.informatik.uni-halle.de/~ladischc/usbmidid.html>.

It requires a kernel with USB and usbdevfs support (obviously), and
with hotplugging support and hotplugging scripts installed correctly.

It should work with most USB MIDI devices, but currently it has been
tested with Roland SC-8820 only. I don't have the slightest idea
whether the code for parsing the device descriptors of fully compliant
devices works at all. :-) So, please tell me if it works for you.


Clemens

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
