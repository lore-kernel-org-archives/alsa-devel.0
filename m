From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 0/3] Add digital mic support to
	TLV320AIC3X and N810
Date: Wed, 25 Jun 2008 14:58:44 +0300
Message-ID: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6912D2437B
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 13:59:48 +0200 (CEST)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PBxJqI008372
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 14:59:46 +0300
Received: from localhost.localdomain (esdhcp04052.research.nokia.com
	[172.21.40.52])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	m5PBwRgg003837
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 14:58:27 +0300
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

Hi

These patches are built on top of my recent generic register modifier widget
patches:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008778.html

Basically AIC3x will capture data either from its ADC converter or from
external digital mic. Therefore I named this input selection in n810.c
as "Input Select" == "ADC" | "Digital Mic".


-- 
Jarkko
