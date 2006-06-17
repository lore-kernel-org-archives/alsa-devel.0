From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001988]: No microphone input on Dell
	Inspiron 6400
Date: Sun, 18 Jun 2006 00:11:47 +0200
Message-ID: <6de1eadf1e7fc0fcf60cee50486aee8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3E82AEB
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jun 2006 00:11:47 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1988> 
======================================================================
Reported By:                tbecker37
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1988
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2080_FC5smp
======================================================================
Date Submitted:             03-31-2006 21:28 CEST
Last Modified:              06-18-2006 00:11 CEST
======================================================================
Summary:                    No microphone input on Dell Inspiron 6400
Description: 
Installing the 1.0.11rc4 driver enabled sound output both for extenal and
headphone jack. However microphone input does not work.  Mic input is
displayed in alsamixer but is not adjustable.

I have also compiled and tried the driver from CVS on 3-31 with no
success.
======================================================================

----------------------------------------------------------------------
 maiquel - 06-18-06 00:03 
----------------------------------------------------------------------
I can reproduce this on a Dell Latitude 120L laptop (Sigmatel 9200 chip),
with Mandriva Linux 2006, kernels: 2.6.12-18mdk (rpm from 'cooker'
repository), 2.6.12.18 (compiled by me) and 2.6.12-18mdk (rpm from de
official DVD).

I have compiled the alsa 1.0.11 against the kernel 2.6.12.18. 

The command:
cat /proc/asound/version

Returned:
Advanced Linux Sound Architecture Driver Version 1.0.11.
Compiled on May 30 2006 for kernel 2.6.16.18.

One interesting thing is that with 1.0.11 there is some noise when I
unmute line-in (external microphone, in this model there isn't a internal
one) and try to record something. The amplitude response is ok and actualy
I'm able to hear my voice (when a speak loud) but there is a lot of noise.


I think this issue is replicated by 0002038.

----------------------------------------------------------------------
 rlrevell - 06-18-06 00:11 
----------------------------------------------------------------------
Please add your comment to #2038, I am closing this bug - the problem was
bad mixer settings.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 21:28 tbecker37      New Issue                                    
03-31-06 21:28 tbecker37      Distribution              => Fedora Core 5   
03-31-06 21:28 tbecker37      Kernel Version            => 2.6.16-1.2080_FC5smp
03-31-06 23:39 tbecker37      Issue Monitored: tbecker37                    
04-03-06 08:03 anarki         Note Added: 0009087                          
04-03-06 19:31 rlrevell       Note Added: 0009104                          
04-03-06 19:43 anarki         Note Added: 0009105                          
04-12-06 16:00 tbecker37      Note Added: 0009244                          
04-17-06 19:28 tbecker37      Note Edited: 0009244                         
04-17-06 19:30 tbecker37      Issue End Monitor: tbecker37                    
06-18-06 00:03 maiquel        Note Added: 0010291                          
06-18-06 00:06 maiquel        Issue Monitored: maiquel                     
06-18-06 00:11 rlrevell       Note Added: 0010292                          
======================================================================
