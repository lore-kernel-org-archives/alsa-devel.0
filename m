From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002161]: Build ALSA to play file wave
Date: Fri, 26 May 2006 12:12:16 +0200
Message-ID: <2e066a35a46378dcd64c4d0be6fbddd7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1B8F15E
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 12:12:16 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2161> 
======================================================================
Reported By:                pvtuan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2161
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11-1.1369_FC4
======================================================================
Date Submitted:             05-26-2006 12:12 CEST
Last Modified:              05-26-2006 12:12 CEST
======================================================================
Summary:                    Build ALSA to play file wave
Description: 
I write a example to open sound card and playback a wave file. In my file I
want to know sizeof type "snd_pcm_hw_params_t". So I use function
"sizeof(snd_pcm_hw_params_t)" for my purpose. When I build my example,
there is an error:invalid application of `sizeof' to incomplete type. I
try to find definition of this type but only se "typedef
_snd_pcm_hw_params snd_pcm_hw_params_t" and no more.

Can you help me with this problem?

Thank you for your help.
Thanks in advance
PVTuan
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-06 12:12 pvtuan         New Issue                                    
05-26-06 12:12 pvtuan         Kernel Version            => 2.6.11-1.1369_FC4
======================================================================
