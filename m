From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001276]: Audigy 2 ZS [SB0350] - Only static noise when playing any sound.
Date: Fri, 28 Oct 2005 14:49:45 +0200
Message-ID: <f28e013cd2bd36ff1d611c77dfc09e3f@85.132.177.35>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from 85.132.177.35 (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3BED81AE
	for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2005 14:49:46 +0200 (MEST)
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
<https://85.132.177.35/alsa-bug/view.php?id=1276> 
======================================================================
Reported By:                colding
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1276
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Gentoo AMD64 2005.0
Kernel Version:             Linux omc-2 2.6.12-gentoo-r6 #2 SMP Fri Jul 22
20:12:38 CEST 2005 x86_64 AMD Opteron(tm) Processor 252 AuthenticAMD GNU/Linux
======================================================================
Date Submitted:             07-22-2005 22:13 CEST
Last Modified:              10-28-2005 14:49 CEST
======================================================================
Summary:                    Audigy 2 ZS [SB0350] - Only static noise when
playing any sound.
Description: 
I have a Audigy 2 ZS [SB0350] sound card installed in my dual 252 Opteron.
I have enabled ALSA and OSS emulation in the kernel. I have tried as
compiled in, no modules, and as module. The card is correctly detected on
boot-up
and apparently activated. 

Everything seems to be configured correctly according to the alsa guide
for Gentoo and all I could find at alsa-project and for Gnome. 

The problem is that I am only hearing cyclically repeating clicks, with
weak static noise in-between, when I am trying to play music. I have a
set of analog 2.1 speakers (Altec Lansing FX-6021) connected to the
analog output jack (Line Out 1) on the card.

It seems that my problems are the same as in this former post to the
list:

http://sourceforge.net/mailarchive/message.php?msg_id=11662616

That thread concluded with no solution but to revert to OSS.

======================================================================

----------------------------------------------------------------------
 pomac - 10-25-05 10:52 
----------------------------------------------------------------------
Ok =)

copy the patch file into /usr/portage/media-sound/alsa-driver/files
edit the approprate ebuild adding:
epatch ${FILESDIR}/${PN}-1.0.10_rc2-dma.patch

just before:
convert_to_m ${S}/Makefile

then, do ebuild 'ebuild file' digest and youre ready to emerge.
I did this with 1.0.10-rc2 and since i had used the in kernel version
before i also removed /etc/asound.state (since it changes sometimes).

If you have a portdir_overlay i could actually tar it up for you later
today.

Anyways, then just remove the old sound modules (use -f if you use gnome
(the mixer applet will be killed and it'll want to restart it, much
easier))
then just start alsasound using the init.d file =)

(perhaps i should have finished my coffee first, but i hope i wasn't too
thurough =)

----------------------------------------------------------------------
 colding - 10-28-05 14:49 
----------------------------------------------------------------------
I finally got time to test alsa-driver-1.0.10_rc2-dma.patch. The good news
is that it works. I now have ALSA sound on my 8GB dual opteron on gentoo
:-)

The bad news is that a shitload of warnings rolls by when booting. I
assume they are harmless debug messages, but I wanted to tell anyway.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 22:13 colding        New Issue                                    
07-22-05 22:13 colding        Distribution              => Gentoo AMD64 2005.0
07-22-05 22:13 colding        Kernel Version            => Linux omc-2
2.6.12-gentoo-r6 #2 SMP Fri Jul 22 20:12:38 CEST 2005 x86_64 AMD Opteron(tm)
Processor 252 AuthenticAMD GNU/Linux
07-23-05 12:53 colding        Issue Monitored: colding                     
07-23-05 15:47 colding        Note Added: 0005553                          
08-16-05 12:34 pzad           Note Added: 0005826                          
08-16-05 16:52 rlrevell       Note Added: 0005829                          
08-16-05 16:53 rlrevell       Status                   new => feedback     
08-17-05 09:05 colding        Note Added: 0005834                          
09-17-05 18:52 jdthood        Note Added: 0006252                          
09-19-05 09:25 colding        Note Added: 0006276                          
09-22-05 15:14 jdthood        Status                   feedback => acknowledged
10-24-05 15:05 pomac          File Added: digest-alsa-driver-1.0.10_rc2         
          
10-24-05 15:06 pomac          File Added: alsa-driver-1.0.10_rc2-dma.patch      
             
10-24-05 15:09 pomac          Note Added: 0006518                          
10-24-05 15:22 jcdutton       Note Added: 0006520                          
10-24-05 15:37 pomac          Note Added: 0006521                          
10-25-05 05:56 rlrevell       Note Added: 0006526                          
10-25-05 09:27 colding        Note Added: 0006527                          
10-25-05 10:34 pomac          Note Added: 0006529                          
10-25-05 10:43 colding        Note Added: 0006530                          
10-25-05 10:52 pomac          Note Added: 0006531                          
10-28-05 14:49 colding        Note Added: 0006568                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
