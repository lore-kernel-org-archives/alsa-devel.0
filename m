From: Pankaj DEV <pankaj.dev@st.com>
Subject: Compilation error for static build of alsa-utils 1.0.26
Date: Fri, 7 Dec 2012 14:33:22 +0800
Message-ID: <7C5AEAE2DCC6B24D92612A29E172F04A2476A2688B@EAPEX1MAIL2.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
 [207.126.144.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 939D52625D5
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 07:33:26 +0100 (CET)
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 55486DF
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 06:25:11 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
 by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C1D64D30
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 06:33:22 +0000 (GMT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

When building alsa (using buildroot) for static build, compilation errors occur.
Don't know how to report bug, since the "bug tracker" link on web-page doesn't open

The following patch solves the issue :
--- a/configure
+++ b/configure
@@ -6247,7 +6247,7 @@ if test "$alsa_prefix" != "" ; then
               LDFLAGS="$LDFLAGS $ALSA_LIBS"
fi
-ALSA_LIBS="$ALSA_LIBS -lasound -lm -ldl -lpthread"
+ALSA_LIBS="$ALSA_LIBS -lasound -lm -lpthread"
LIBS="$ALSA_LIBS $LIBS"
{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ALSA_LIBS" >&5
$as_echo "$ALSA_LIBS" >&6; }
