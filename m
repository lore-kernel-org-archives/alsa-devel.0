From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: defaults.pcm.minperiodtime 5000
Date: Thu, 12 Aug 2010 08:59:41 +0800
Message-ID: <AANLkTinW0tbBLOczuTY=2p2+EZQrqBAFdEHdLeOFX8y5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7C9D0243A7
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 02:59:41 +0200 (CEST)
Received: by ewy21 with SMTP id 21so402980ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 17:59:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It seem that there is a bug in the patch which remove "if ( err < 0 )"


-       if (err < 0)
                return err;
+       if (pcm->minperiodtime > 0) {


http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=09879a4bb58199f64abcb8df506f917c8efc2383;hp=e6d5dcf1f625984605d362338d71162de45a6c60

BTW , it seem this patch change the behaviour of alsa-lib too.

all sound cards will now have a minperiodtime 5000
