From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000963]: Sounc card is mute
Date: Tue, 9 Aug 2005 13:05:46 +0200
Message-ID: <7a0a3981c21d8cf8ea27060707768476@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EC5241AC
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:05:46 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=963> 
======================================================================
Reported By:                jnilles
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   963
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               SuSE
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-04-2005 19:07 CET
Last Modified:              08-09-2005 13:05 CEST
======================================================================
Summary:                    Sounc card is mute
Description: 
I have a Turtle Beach Santa Cruz. It worked perfectly with SuSE Linux 9.0
and still works perfectly under Windows XP. I "upgraded" to SuSE 9.2 and
the sound card is inoperative, mute, lifeless, sound-free. The only advice
I got from SuSE support was that I shouldn't have skipped from 9.0 to 9.2
without going thgrough 9.1 on the way. That sounds like pretty stupid
advice.
I have spent weeks twiddling with settings  recommended by member sof the
alsa users group, to no avail.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000988 No errors, but no sound output
======================================================================

----------------------------------------------------------------------
 jnilles - 03-23-05 20:03 
----------------------------------------------------------------------
As an addition to madCoder's  remarks, I suggest that the default setting
of External Amplifier should be 'On'. Had that been the case many hours of
messing about by all concerned would have been saved.

----------------------------------------------------------------------
 perex - 08-09-05 13:05 
----------------------------------------------------------------------
This bug was resolved - mixer settings.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 19:07 jnilles        New Issue                                    
03-04-05 19:07 jnilles        Distribution              => SuSE            
03-09-05 18:53 tiwai          Note Added: 0003840                          
03-10-05 00:21 jnilles        Note Added: 0003846                          
03-10-05 15:01 jdthood        Note Added: 0003856                          
03-10-05 20:29 jnilles        Note Added: 0003872                          
03-10-05 22:04 jdthood        Note Added: 0003874                          
03-16-05 01:33 jnilles        Note Added: 0003926                          
03-16-05 12:31 tiwai          Note Added: 0003941                          
03-16-05 22:52 jnilles        Note Added: 0003972                          
03-17-05 10:11 jdthood        Note Added: 0003980                          
03-17-05 23:07 jnilles        Note Added: 0003986                          
03-18-05 14:38 jdthood        Note Added: 0003993                          
03-18-05 17:59 tiwai          Note Added: 0003997                          
03-18-05 22:42 jnilles        Note Added: 0004006                          
03-19-05 09:44 jdthood        Note Added: 0004025                          
03-19-05 18:55 jnilles        Note Added: 0004066                          
03-22-05 14:58 jdthood        Note Added: 0004125                          
03-22-05 15:13 jdthood        Relationship added       has duplicate 0000988
03-22-05 15:14 jdthood        Severity                 major => minor      
03-22-05 15:14 jdthood        Status                   new => acknowledged 
03-23-05 01:00 madCoder       Note Added: 0004147                          
03-23-05 01:01 madCoder       Note Edited: 0004147                         
03-23-05 09:15 jdthood        Note Added: 0004151                          
03-23-05 19:20 jnilles        Note Added: 0004184                          
03-23-05 20:03 jnilles        Note Added: 0004186                          
03-24-05 21:52 Ariel          Issue Monitored: Ariel                       
08-09-05 13:05 perex          Status                   acknowledged => resolved
08-09-05 13:05 perex          Resolution               open => fixed       
08-09-05 13:05 perex          Assigned To               => perex           
08-09-05 13:05 perex          Note Added: 0005725                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
