From: Timur Tabi <timur@freescale.com>
Subject: Unable to find an usable access for 'default'
Date: Tue, 03 Jul 2007 17:19:50 -0500
Message-ID: <468ACB86.1040303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E315A10383E
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 00:19:54 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l63MJplp006957
	for <alsa-devel@alsa-project.org>; Tue, 3 Jul 2007 15:19:52 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l63MJo23018753
	for <alsa-devel@alsa-project.org>; Tue, 3 Jul 2007 17:19:51 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm developing a new ASOC driver, and I get this error message:

ALSA lib pcm_plug.c:729:(snd_pcm_plug_hw_refine_schange) Unable to find an usable access 
for 'default'

Can someone tell me what this means?

FYI, I'm in the early stages of testing my driver, and before I started I knew nothing 
about ALSA.  This is on an embedded system, so I don't know if my ALSA installation is 
correct.  Am I missing some kind of configuration file?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
