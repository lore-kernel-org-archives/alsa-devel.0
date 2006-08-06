From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000998]: access to second playback
	hangs
Date: Sun, 6 Aug 2006 14:20:59 +0200
Message-ID: <4aaebf610ec186a35105ba963ac989c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7642F175
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 14:20:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=998> 
======================================================================
Reported By:                allefant
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   998
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-6
======================================================================
Date Submitted:             03-19-2005 00:16 CET
Last Modified:              08-06-2006 14:20 CEST
======================================================================
Summary:                    access to second playback hangs
Description: 
This is haunting my since about half a year, since I got this card. Every
time the second playback device is accessed, there's a complete hardware
freeze. Disabling the second playback device makes it work. I know, this
isn't the best report, since I didn't compile the latest version and did
not much testing (no fun getting constant HW freezes) - but anyway, I
thought I report it here, maybe my workaround can help someone who googles
for this problems at least (or, maybe someone can give me even a hint how
to fix it).
======================================================================

----------------------------------------------------------------------
 Raymond - 07-14-06 15:54 
----------------------------------------------------------------------
The driver only allow either playback on second subdevice or capture but
not both together.

----------------------------------------------------------------------
 Raymond - 08-06-06 14:20 
----------------------------------------------------------------------
Reducing the number of subdevices from 2 to 1 mean the driver need dmix and
dsnoop

However dmix doesn't like the driver support both mono and stereo.

static struct snd_pcm_hardware snd_es1938_playback =
{ 

.channels_min = 1,
.channels_max = 2,

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 00:16 allefant       New Issue                                    
03-19-05 00:16 allefant       Distribution              => Debian sid      
03-19-05 00:16 allefant       Kernel Version            => 2.6.10-6        
04-06-05 00:30 allefant       Note Added: 0004344                          
04-06-05 12:34 allefant       Note Added: 0004345                          
04-06-05 12:49 allefant       Note Added: 0004346                          
07-14-06 15:54 Raymond        Note Added: 0010999                          
08-06-06 14:20 Raymond        Note Added: 0011467                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
