From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002174]: No sound at all using
	snd-hda-intel / alsa-1.0.11
Date: Sun, 18 Jun 2006 12:44:48 +0200
Message-ID: <237e1e74827869f76d0d0fac19fcdbb6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 644F2162
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jun 2006 12:44:48 +0200 (MEST)
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
Last Modified:              06-18-2006 12:44 CEST
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

----------------------------------------------------------------------
 rlrevell - 06-17-06 19:57 
----------------------------------------------------------------------
Um, 3 days without an update is not exactly "stalled".

As far as next steps, it's hard - often the problem is lack of hardware
information.  Read the ALSA source code and alsa-devel archives.  Maybe
you can create a test model for your soundcard.

----------------------------------------------------------------------
 jlpedrosa - 06-18-06 12:44 
----------------------------------------------------------------------
Hi again...

if the problem is the same of 2035, from the ALC861, in realtek there is a
very complete hardware specifications, with pin and signal diagrams. I
don't know if it said in english.. but here it goes.. "chronograms" and a
lot of documentation...

http://www.realtek.com.tw/downloads/downloads1-3.aspx?Keyword=861

if anyone needs to do some testing i offer my computer.

(Wanna hear music!!) :)

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
======================================================================
