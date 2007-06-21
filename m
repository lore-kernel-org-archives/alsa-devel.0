From: Timur Tabi <timur@freescale.com>
Subject: What is CONFIG_I2C_MODULE?
Date: Thu, 21 Jun 2007 14:40:37 -0500
Message-ID: <467AD435.7000807@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D0A310385A
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 21:40:41 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5LJecfk029202
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 12:40:39 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5LJebG9021077
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 14:40:38 -0500 (CDT)
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

In a lot of ALSA drivers, I see this:

#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

What is CONFIG_I2C_MODULE?  I've searched all the Kconfigs, and I cannot see this 
configuration option.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
