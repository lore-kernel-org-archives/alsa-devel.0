From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: ALI M5451 (CMI 9739): PCM always muted?
Date: Sat, 17 Apr 2004 19:45:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404171945.35824.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from test.arklinux.org (build.arklinux.oregonstate.edu [128.193.0.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA18643
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2004 19:48:11 +0200
Received: from [10.0.0.8] (A46ce.a.pppool.de [213.6.70.206])
	by test.arklinux.org (Postfix) with ESMTP id A7384DD77A
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2004 10:57:58 -0700 (PDT)
Content-Disposition: inline
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

Hi,
On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID 1019:0f22), 
snd_ali5451 loads and can adjust mixer settings (except for PCM volume, but I 
think that's a limitation of the hardware), but doesn't make any noise - 
apparently PCM is always muted (volume fixed at 0?).

Is this a known bug? Didn't have the time to check the code yet...

LLaP
bero


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
