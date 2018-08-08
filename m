From: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Subject: [PATCH - hwmixvolume 7/9] hwmixvolume: switch the
	shebang to python, as it is now compatible with both 2 and 3
Date: Wed,  8 Aug 2018 17:56:35 +0200
Message-ID: <20180808155637.5592-8-linkmauve@jabberfr.org>
References: <20180808155637.5592-1-linkmauve@jabberfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180808155637.5592-1-linkmauve@jabberfr.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

diff --git a/hwmixvolume/hwmixvolume b/hwmixvolume/hwmixvolume
index ec2d05d..7b90613 100755
--- a/hwmixvolume/hwmixvolume
+++ b/hwmixvolume/hwmixvolume
@@ -1,4 +1,4 @@
-#!/usr/bin/python2
+#!/usr/bin/env python
 
 # hwmixvolume - ALSA hardware mixer volume control applet
 # Copyright (c) 2009-2010 Clemens Ladisch
-- 
2.18.0
