From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000537]: VIA VT8237: rear L/R switched with Center/LFE
Date: Tue, 12 Oct 2004 18:21:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012162151.6095818008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DEAC42E0
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 18:21:51 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000537
======================================================================
Reported By:                gertverv
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     537
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             09-24-2004 19:41 CEST
Last Modified:              10-12-2004 18:21 CEST
======================================================================
Summary:                    VIA VT8237: rear L/R switched with Center/LFE
Description: 
While playing back 5.1 audio, it looks like the rear L/R channels are
swapped with the Center/LFE channels. The rear L/R and Center/LFE are
connected via Gigabyte Surround-Kit.


======================================================================

----------------------------------------------------------------------
 gertverv - 09-24-2004 19:50 CEST 
----------------------------------------------------------------------
Forgot to mention, 5.1 audio works correctly when using Windows XP on this
machine

----------------------------------------------------------------------
 tiwai - 10-12-2004 15:06 CEST 
----------------------------------------------------------------------
Does 4.0 output work properly?

Also, please attach /proc/asound/card0/codec97#0/ac97#0-0+regs
during speaker-test is running with 5.1 mode.

----------------------------------------------------------------------
 gertverv - 10-12-2004 18:21 CEST 
----------------------------------------------------------------------
> Does 4.0 output work properly?

Yes, it does.

>Also, please attach /proc/asound/card0/codec97#0/ac97#0-0+regs
>during speaker-test is running with 5.1 mode.

0:00 = 0180
0:02 = bf3f
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 001e
0:0c = 0000
0:0e = 031f
0:10 = 0404
0:12 = 9f1f
0:14 = 0000
0:16 = 9f1f
0:18 = 0606
0:1a = 0000
0:1c = 0000
0:1e = 8000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 09c7
0:2a = 05f5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = bb80
0:36 = 0e0d
0:38 = 0707
0:3a = 0824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0aea
0:6a = 8000
0:6c = 3601
0:6e = 0002
0:70 = 0008
0:72 = 0000
0:74 = 0105
0:76 = 0000
0:78 = 0002
0:7a = 40b3
0:7c = 414c
0:7e = 4780

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 19:41 gertverv       New Bug                                      
09-24-04 19:41 gertverv       Distribution              => Fedora Core 2   
09-24-04 19:41 gertverv       Kernel Version            => 2.6.8.1         
09-24-04 19:50 gertverv       Bugnote Added: 0001903                       
10-12-04 15:06 tiwai          Bugnote Added: 0002104                       
10-12-04 18:21 gertverv       Bugnote Added: 0002106                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
