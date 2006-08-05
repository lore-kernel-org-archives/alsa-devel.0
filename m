From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002161]: Build ALSA to play file wave
Date: Sat, 5 Aug 2006 13:16:35 +0200
Message-ID: <b70d0bb48625def2978e4bc7e4fd0fe6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5477516B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 13:16:35 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             2.6.11-1.1369_FC4
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-26-2006 12:12 CEST
Last Modified:              08-05-2006 13:16 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0002162 Build ALSA to play file wave
======================================================================

----------------------------------------------------------------------
 jcdutton - 05-26-06 13:37 
----------------------------------------------------------------------
You can't do that.
snd_pcm_hw_params_t details are private to alsa-lib.
alsa-lib has api calls to alloc/free this structure.
alsa-lib also has api calls to retrieve particular settings inside the
structure.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-06 12:12 pvtuan         New Issue                                    
05-26-06 12:12 pvtuan         Kernel Version            => 2.6.11-1.1369_FC4
05-26-06 13:37 jcdutton       Note Added: 0009975                          
05-26-06 14:45 tiwai          Relationship added       has duplicate 0002162
08-05-06 13:16 Adrian Bunk    Status                   new => closed       
08-05-06 13:16 Adrian Bunk    Resolution               open => not an issue
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
