From: Christopher Arndt <chris.arndt@web.de>
Subject: [PATCH] alsa-python: Add support for setuptools
Date: Wed, 05 Aug 2009 15:18:53 +0200
Message-ID: <4A7986BD.7070605@web.de>
References: <4A607468.7010300@web.de>	<4A65C370.3030205@ladisch.de>	<4A65EADE.70007@web.de>	<4A733753.60808@web.de>	<4A76D01F.1090603@ladisch.de>	<4A76D662.9030002@web.de>	<4A78033F.5020504@ladisch.de>	<4A78170B.7070400@web.de>
	<4A783187.1070600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id C97C624457
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 15:18:38 +0200 (CEST)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id DC18F10FF9B1B
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 15:18:37 +0200 (CEST)
Received: from [87.79.63.199] (helo=minimax.paddyland.lan)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314) id 1MYgO5-0000f6-00
	for alsa-devel@alsa-project.org; Wed, 05 Aug 2009 15:18:37 +0200
In-Reply-To: <4A783187.1070600@ladisch.de>
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

This patch adds support for setuptools to the setup.py file of python-alsa.

Signed-off-by: Christopher Arndt <chris@chrisarndt.de>

diff --git a/setup.py b/setup.py
index fa7f2d6..c2b6389 100755
--- a/setup.py
+++ b/setup.py
@@ -3,7 +3,10 @@

 import os
 import sys
-from distutils.core import setup, Extension
+try:
+    from setuptools import setup, Extension
+except ImportError:
+    from distutils.core import setup, Extension

 VERSION='1.0.20'
