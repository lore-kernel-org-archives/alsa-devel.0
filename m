From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002304]: Realtek ALC655 rev 0 record
	background noise
Date: Tue, 25 Jul 2006 14:58:50 +0200
Message-ID: <c208f52badc3090ea7d29c4c5f82d002@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E35F423C
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Jul 2006 14:58:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2304> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2304
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             07-25-2006 14:58 CEST
Last Modified:              07-25-2006 14:58 CEST
======================================================================
Summary:                    Realtek ALC655 rev 0 record background noise
Description: 
there is always a background noise on the right channel when you want to
record via the line in.

cat /proc/asound/card2/codec97#0/ac97#0-0
0-0/0: Realtek ALC655 rev 0

PCI Subsys Vendor: 0x1462
PCI Subsys Device: 0xb010

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x8086
Subsys. ID       : 0x1234

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF
Extended status  : SPCV LDAC SDAC CDAC SPDIF=10/11
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

When you want to change the input level this one is very high by default
it is quasi impossible to adjust it like if we are in mic input.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-25-06 14:58 croiset        New Issue                                    
07-25-06 14:58 croiset        Distribution              => Redhat 7.2      
07-25-06 14:58 croiset        Kernel Version            => 2.4.7-10        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
