From: Timur Tabi <timur@freescale.com>
Subject: mplayer plays video twice as fast with Alsa than with
	OSS
Date: Tue, 23 Oct 2007 12:20:14 -0500
Message-ID: <471E2D4E.3080400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C367524A16
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 19:20:29 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9NHKF0Z003916
	for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2007 10:20:26 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9NHKEtD010458
	for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2007 12:20:15 -0500 (CDT)
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

Hi,

I wrote an Alsa device driver that supposedly works with the OSS emulation, but 
one of our customers is reporting that mplayer with the "-ao oss" option plays 
video twice at double speed.  If they select "-ao alsa" instead, then it plays 
normally.

Is this a known problem?
