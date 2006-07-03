From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002174]: No sound at all using
	snd-hda-intel / alsa-1.0.11
Date: Mon, 3 Jul 2006 22:06:27 +0200
Message-ID: <1b8f6be058bd7ccbba2b3a57a304cb7f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89A8D237
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 22:06:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174> 
======================================================================
Reported By:                carllivitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2174
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2122_FC5smp
======================================================================
Date Submitted:             05-30-2006 17:11 CEST
Last Modified:              07-03-2006 22:06 CEST
======================================================================
Summary:                    No sound at all using snd-hda-intel / alsa-1.0.11
Description: 
On my new Toshiba Satellite Pro P100 laptop, I cannot get sound from the
speakers or headphone jack. It has never worked.

I've used the standard FC5 kernel and the updated kernel
(2.6.16-1.2122FC5smp) without success. 

I've downloaded and installed the alsa-*-1.0.11 drivers etc, but still no
sound. Everything is unmuted, alsamixer can turn the volume controls up
and down, KDE's kmix also works fine but still no sound. There are no
error messages in the syslog. 

I've also tried using the 'single_cmd=1' module loading option. 

I tried the CVS version of ALSA, but it didn't work with my kernel - there
were unresolved symbols that I couldn't resolve. I'm back to using the
1.0.11 version.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001957 HP dv8000t hda-intel codec not recognized
======================================================================

----------------------------------------------------------------------
 haight - 07-03-06 22:03 
----------------------------------------------------------------------
Here is another codec dump from a system with a similar problem.  The HP
Pavilion dv8000 which I got at Fry's this past week.

I can hear audio, but it is very quiet.  Haven't tested the headphone
jack.  I have tried various "model" options, including of course "hp",
with the same results.  My mixer shows only a PCM, no master volume.

I'm using Suse 10.1, with the standard kernel (2.6.16.13-4-smp).  

lspci -v shows:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Aud
io Controller (rev 01)
        Subsystem: Hewlett-Packard Company Unknown device 30a5
        Flags: bus master, fast devsel, latency 0, IRQ 74
        Memory at d2400000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable
-
        Capabilities: [70] Express Unknown type IRQ 0

If anyone needs more information from me, or wants to use my system as a
test platform, don't hesitate to ask.  Contact me at www.julianhaight.com.
 I'm also monitoring this bug and anxiously awaiting a fix, thanks for the
free software!

-=Julian=-



----------------------------------------------------------------------
 rlrevell - 07-03-06 22:06 
----------------------------------------------------------------------
If you just picked up the machine last week I'd consider exchanging it for
one that works with Linux.  Take a live CD to the store with you.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 17:11 carllivitt     New Issue                                    
05-30-06 17:11 carllivitt     Distribution              => Fedora Core 5   
05-30-06 17:11 carllivitt     Kernel Version            => 2.6.16-1.2122_FC5smp
06-04-06 23:36 carllivitt     Issue Monitored: carllivitt                    
06-04-06 23:37 carllivitt     Note Added: 0010065                          
06-12-06 21:51 carllivitt     Note Added: 0010174                          
06-12-06 22:03 rlrevell       Note Added: 0010175                          
06-12-06 22:52 carllivitt     Note Added: 0010176                          
06-12-06 22:54 rlrevell       Note Added: 0010177                          
06-12-06 23:10 carllivitt     Note Added: 0010178                          
06-12-06 23:14 rlrevell       Note Added: 0010179                          
06-12-06 23:29 carllivitt     Note Added: 0010180                          
06-12-06 23:35 rlrevell       Note Added: 0010181                          
06-12-06 23:49 carllivitt     Note Added: 0010182                          
06-12-06 23:58 rlrevell       Note Added: 0010183                          
06-13-06 15:33 godeater       Note Added: 0010193                          
06-13-06 18:13 rlrevell       Note Added: 0010198                          
06-13-06 18:53 jlpedrosa      Note Added: 0010199                          
06-13-06 18:58 rlrevell       Note Added: 0010200                          
06-13-06 19:17 jlpedrosa      Note Added: 0010202                          
06-14-06 10:11 carllivitt     File Added: lspci-nv.txt                     
06-14-06 10:12 carllivitt     Note Added: 0010207                          
06-14-06 10:21 carllivitt     File Added: codec0.txt                       
06-14-06 10:21 carllivitt     Note Added: 0010208                          
06-14-06 13:17 jlpedrosa      Note Added: 0010210                          
06-14-06 16:13 jlpedrosa      Note Edited: 0010210                         
06-17-06 19:51 carllivitt     Note Added: 0010288                          
06-17-06 19:57 rlrevell       Note Added: 0010289                          
06-18-06 12:44 jlpedrosa      Note Added: 0010299                          
06-19-06 08:42 fatman         Note Added: 0010306                          
06-19-06 13:36 jlpedrosa      Note Added: 0010308                          
06-19-06 13:49 jlpedrosa      Note Edited: 0010308                         
06-20-06 11:04 carllivitt     Note Added: 0010332                          
06-20-06 11:21 fatman         Note Added: 0010333                          
06-20-06 17:38 legoguy        Note Added: 0010338                          
06-20-06 17:39 legoguy        Issue Monitored: legoguy                     
06-20-06 19:38 tiwai          Note Added: 0010341                          
06-20-06 19:45 rlrevell       Relationship added       duplicate of 0001957
06-20-06 23:51 jlpedrosa      Note Added: 0010361                          
06-21-06 17:47 carllivitt     Note Added: 0010399                          
06-21-06 18:44 rlrevell       Note Added: 0010401                          
06-22-06 10:39 carllivitt     Note Added: 0010420                          
06-22-06 17:50 GrueMaster     Note Added: 0010426                          
06-26-06 14:29 Ytorres        Note Added: 0010535                          
06-26-06 14:47 Ytorres        Issue Monitored: Ytorres                     
07-03-06 21:50 haight         Issue Monitored: haight                      
07-03-06 21:55 haight         File Added: codec.txt                        
07-03-06 22:01 haight         Note Added: 0010808                          
07-03-06 22:03 haight         Note Edited: 0010808                         
07-03-06 22:06 rlrevell       Note Added: 0010809                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
