From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001949]: pcm.jack config in alsa-plugins/doc/README-jack
Date: Tue, 21 Mar 2006 07:42:13 +0100
Message-ID: <34fe1901ae42b64598944e7584cdfbc1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E2E01EC
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 07:42:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1949> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1949
Category:                   PCM - jack
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-21-2006 06:18 CET
Last Modified:              03-21-2006 07:42 CET
======================================================================
Summary:                    pcm.jack config in alsa-plugins/doc/README-jack
Description: 
In  alsa-plugins/doc/README-jack

   pcm.jack {
		type jack
		playback_ports {
			0 alsa_pcm:playback_1
			1 alsa_pcm:playback_1
		}
		capture_ports {
			0 alsa_pcm:capture_1
			1 alsa_pcm:pcapture_1
		}
	}

There are four entries in Writable clients in qjackctl (jack-0.100.0) 

playback_1
playback_2
playback_3
playback_4

two entries in Readable clients

capture_1
capture_2

======================================================================

----------------------------------------------------------------------
 Raymond - 03-21-06 07:42 
----------------------------------------------------------------------
aplay -Djack stereo.wav
ALSA lib pcm.c:2109:(snd_pcm_open_conf) Cannot open shared library
/usr/lib/alsa-lib/libasound_module_pcm_jack.so
aplay: main:547: audio open error: No such file or directory

ls /usr/lib/alsa-lib
libasound_module_ctl_oss.la   libasound_module_pcm_jack.so  smixer
libasound_module_ctl_oss.so   libasound_module_pcm_oss.la
libasound_module_pcm_jack.la  libasound_module_pcm_oss.so

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 06:18 Raymond        New Issue                                    
03-21-06 07:42 Raymond        Note Added: 0008738                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
