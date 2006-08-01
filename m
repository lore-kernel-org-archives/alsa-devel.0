From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001737]: The field ipc_gid must be a
	valid group (create group audio)
Date: Tue, 1 Aug 2006 14:05:46 +0200
Message-ID: <ab7eb9012b39ee7342f41456e071ff63@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1F227191
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 14:05:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1737> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1737
Category:                   0_general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-11-2006 12:12 CET
Last Modified:              08-01-2006 14:05 CEST
======================================================================
Summary:                    The field ipc_gid must be a valid group (create
group audio)
Description: 
/etc/group is not exist in Fedora Core 1

if alsa developer recommend application to use "default", the "default"
device should work in all platform including Fedore Core 1.


https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1617

intel8x0 as card 0


speaker-test -c 2
 
speaker-test 1.0.11rc2
 
Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
ALSA lib pcm_dmix.c:1135:(_snd_pcm_dmix_open) The field ipc_gid must be a
valid group (create group audio)
Playback open error: -22,Invalid argument
ALSA lib pcm_dmix.c:1135:(_snd_pcm_dmix_open) The field ipc_gid must be a
valid group (create group audio)
Playback open error: -22,Invalid argument

 
speaker-test -c 2 -D plughw:0,0
 
speaker-test 1.0.11rc2
 
Playback device is plughw:0,0
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 8 to 16384
Period size range from 8 to 16384
Periods = 4
Buffer time size 2525
To choose buffer_size = 16384
To choose period_size = 4096
was set period_size = 4096
was set buffer_size = 16384
 0 - Front Left
 1 - Front Right
Time per period = 5.633373
 0 - Front Left

 aplay test.wav
ALSA lib pcm_dmix.c:1135:(_snd_pcm_dmix_open) The field ipc_gid must be a
valid group (create group audio)
aplay: main:547: audio open error: Invalid argument

 aplay -D plughw:0,0 test.wav
Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo






======================================================================

----------------------------------------------------------------------
 Raymond - 08-01-06 14:05 
----------------------------------------------------------------------
Please close this bug report as I had solved the problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 12:12 Raymond        New Issue                                    
08-01-06 14:05 Raymond        Note Added: 0011374                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
