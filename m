From: olivier@trillion01.com
Subject: [PATCH] Remove an obsolete macro in configure.in
Date: Thu, 16 May 2013 04:32:58 -0400
Message-ID: <1368693178-30659-1-git-send-email-olivier@trillion01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy6-pub.bluehost.com (oproxy6-pub.bluehost.com
 [67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id 60332265516
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 15:33:52 +0200 (CEST)
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
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Olivier Langlois <olivier@trillion01.com>

Replaced AM_CONFIG_HEADER with AC_CONFIG_HEADERS

lano1106@whippet2 ~/dev/alsa-lib $ ./gitcompile
aclocal: warning: autoconf input should be named 'configure.ac', not 'configure.in'
configure.in:56: error: 'AM_CONFIG_HEADER': this macro is obsolete.
    You should use the 'AC_CONFIG_HEADERS' macro instead.
/usr/share/aclocal-1.13/obsolete-err.m4:12: AM_CONFIG_HEADER is expanded from...
configure.in:56: the top level
autom4te: /usr/bin/m4 failed with exit status: 1
aclocal: error: echo failed with exit status: 1

Signed-off-by: Olivier Langlois <olivier@trillion01.com>

diff --git a/configure.in b/configure.in
index ed3fe04..207e154 100644
--- a/configure.in
+++ b/configure.in
@@ -53,7 +53,7 @@ CC_NOUNDEFINED
 
 dnl Checks for header files.
 AC_HEADER_STDC
-AM_CONFIG_HEADER(include/config.h)
+AC_CONFIG_HEADERS(include/config.h)
 
 dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
-- 
1.8.2.3
