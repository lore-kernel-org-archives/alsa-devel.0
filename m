From: Timur Tabi <timur@freescale.com>
Subject: alsaplayer configure says Build alsa 0.9.x output
	plugin: no
Date: Fri, 07 Sep 2007 12:58:11 -0500
Message-ID: <46E19133.8020208@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F34F2417D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 19:58:16 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l87HwC8V003497
	for <alsa-devel@alsa-project.org>; Fri, 7 Sep 2007 10:58:13 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87HwBn8010953
	for <alsa-devel@alsa-project.org>; Fri, 7 Sep 2007 12:58:12 -0500 (CDT)
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

I have a working ALSA driver on my system.  I downloaded the latest alsaplayer 
and when I ran ./configure, it says this:

   Build alsa 0.9.x output plugin:     no

I looked at the source code for configure, and I found this:

  if (eval "$ac_cpp conftest.$ac_ext") 2>&5 |
   $EGREP "AP_maGiC_VALUE" >/dev/null 2>&1; then
   have_alsa_final=yes

But I don't understand it.

What do I need to have to get alsaplayer to build ALSA output support?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
