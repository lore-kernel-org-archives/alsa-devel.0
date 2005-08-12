From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001053]: cannot change line-in volume on MSI K8N Platinum that has SBLive! 24 bit
Date: Sat, 13 Aug 2005 01:16:02 +0200
Message-ID: <b51dcecff30db2025de5c6a650855bcc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D6626196
	for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2005 01:16:02 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1053> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1053
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4 test 2
Kernel Version:             2.6.11-1.1236 FC4-x86_64 that contains 2.6.12rc2
======================================================================
Date Submitted:             04-14-2005 19:27 CEST
Last Modified:              08-13-2005 01:16 CEST
======================================================================
Summary:                    cannot change line-in volume on MSI K8N Platinum
that has SBLive! 24 bit
Description: 
I have a MSI K8N Platinum motherboard that has SBLive! 24 bit integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack in the pci version of the sb live 24
bit (see image).

The result is that I cannot use line-in for my soundcard becuase the
volume is 0 and I cannot change it.

The "Capture feedback into playback" in the mixer change the mic's volume.
======================================================================

----------------------------------------------------------------------
 jcdutton - 08-12-05 23:08 
----------------------------------------------------------------------
Please do not change the bug problem half way through a bug report.
My understanding was that you could not capture sound from the mic or line
in.
I understand that you can capture from mic now. Can you capture from line
in ?

If you can now do "arecord ..." and capture from mic and line in. This bug
is fixed. Please tell me if this is working or not? If it is working,
please tell me what parameters you use for "arecord ..." to get it to
work.

The feedback from capture to playback is a separate bug, so please raise a
new bug report about it, but only raise that bug report if this bug is
closed. Otherwise I am going to get confused as to what your problem
actually is.

----------------------------------------------------------------------
 Cimmo - 08-13-05 01:16 
----------------------------------------------------------------------
Sorry I want to say that I cannot hear nothing from line-in.

Close this bug, I will open a new one.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-05 19:27 Cimmo          New Issue                                    
04-14-05 19:27 Cimmo          File Added: MSIK8N.jpg                       
04-14-05 19:27 Cimmo          Distribution              => Fedora Core 4 test 2
04-14-05 19:27 Cimmo          Kernel Version            => 2.6.11-1.1236
FC4-x86_64 that contains 2.6.12rc2
04-14-05 21:42 jcdutton       Note Added: 0004495                          
04-14-05 21:42 jcdutton       Status                   assigned => acknowledged
05-11-05 15:05 Cimmo          Note Added: 0004636                          
05-14-05 13:14 pelias         Note Added: 0004657                          
05-14-05 15:48 jcdutton       Note Added: 0004659                          
05-20-05 00:14 dwh            Note Added: 0004697                          
05-28-05 12:16 jcdutton       Note Added: 0004764                          
05-28-05 12:16 jcdutton       Status                   acknowledged => feedback
05-30-05 12:57 Cimmo          Note Added: 0004805                          
05-30-05 12:58 Cimmo          File Added: alsamixer.jpg                    
05-30-05 14:33 jcdutton       Note Added: 0004814                          
05-30-05 14:56 Cimmo          Note Added: 0004816                          
05-30-05 14:57 Cimmo          Note Edited: 0004816                         
06-01-05 19:44 Cimmo          Note Added: 0004867                          
06-01-05 19:50 Cimmo          Note Edited: 0004867                         
07-01-05 14:03 Cimmo          Note Added: 0005332                          
07-01-05 14:48 jcdutton       Note Added: 0005334                          
07-01-05 20:00 Cimmo          Note Added: 0005336                          
07-14-05 12:32 Cimmo          Note Added: 0005471                          
08-12-05 23:08 jcdutton       Note Added: 0005789                          
08-13-05 01:16 Cimmo          Note Added: 0005797                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
