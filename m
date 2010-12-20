From: David Henningsson <david.henningsson@canonical.com>
Subject: Internal Mic vs Int Mic
Date: Mon, 20 Dec 2010 10:07:38 +0100
Message-ID: <4D0F1CDA.2090009@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D9CF12448F
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 10:07:43 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1PUbiU-0000em-P1
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 09:07:38 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1PUbiU-0006Vu-M5
	for alsa-devel@alsa-project.org; Mon, 20 Dec 2010 09:07:38 +0000
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

To try to clean up a little in the Volume Control namespace, it seems 
"Int Mic" and "Internal Mic" both mean the same thing. "Internal Mic" 
seems to be the winning one as it is used in 
hda_codec.c:hda_get_input_pin_label.

So, would a patch that changes every "Int Mic" to "Internal Mic" be 
appreciated and merged?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
