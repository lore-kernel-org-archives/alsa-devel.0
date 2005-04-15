From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001056]: Realtek ALC 880 on board sound chip not detected.
Date: Fri, 15 Apr 2005 15:52:50 +0200
Message-ID: <a31cdaf512f90edf6af5830f983d5c2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 838CE1E4
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2005 15:52:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1056> 
======================================================================
Reported By:                David Kinzer
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1056
Category:                   alisp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-15-2005 15:51 CEST
Last Modified:              04-15-2005 15:52 CEST
======================================================================
Summary:                    Realtek ALC 880 on board sound chip not detected.
Description: 
Description of problem:
New HP m7060n Media Center PC. (Private ASUS motherboard with integrated
sound.)
Install FC3 core (workstation config) from scratch.
Sound chip is not detected.
Core is "up2date"

>From Specs sheet:
      Integrated Intel High Definition (TM) audio (Azalia) 

          o Realtek ALC 880 chipset
          o THX certification support
          o 8-channels for Full Dolby 5.1/6.1/7.1 surround sound support
with Dolby Pro Logic IIx
          o Dolby 5.1



======================================================================

----------------------------------------------------------------------
 David Kinzer - 04-15-05 15:52 
----------------------------------------------------------------------
I could not find anything similar enough using search facilities, this
seems to be the stuff that experts ask for:
lspci -v excerpt:
02:04.2 Multimedia controller: Conexant: Unknown device 8802 (rev 05)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 4823
        Flags: bus master, medium devsel, latency 64, IRQ 169
        Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [4c] Power Management version 2

lsmod excerpt:
cx8800                 34765  0
v4l1_compat            17605  1 cx8800
v4l2_common             9793  1 cx8800
cx88_blackbird         18501  0
cx8802                 14277  1 cx88_blackbird
cx88xx                 51797  3 cx8800,cx88_blackbird,cx8802
i2c_algo_bit           13001  1 cx88xx
video_buf              25413  4 cx8800,cx88_blackbird,cx8802,cx88xx
btcx_risc               8905  3 cx8800,cx8802,cx88xx
videodev               13633  3 cx8800,cx88_blackbird,cx88xx

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-05 15:51 David Kinzer   New Issue                                    
04-15-05 15:52 David Kinzer   Note Added: 0004501                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
