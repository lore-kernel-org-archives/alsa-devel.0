From: Chrissi k <c.krooss@googlemail.com>
Subject: Intel HDA using VIA vt1708s
Date: Thu, 2 Jul 2009 12:02:22 +0200
Message-ID: <cd6b15f10907020302g6603c08cw12950aa60ddde790@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BAEF246D7
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 12:02:23 +0200 (CEST)
Received: by ewy26 with SMTP id 26so1809004ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2009 03:02:22 -0700 (PDT)
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

Hi, i'd like to report a bug in alsa, up to 1.0.20, in combination with the
via vt1708s codec used for example in the asus X5DIJ laptop
per default, patch_via.c enables EAPD during initialization. That's not the
case especially for the 1708S, so theres no sound at all from internal
laptop speakers and
line-out.
Enabling EAPD using hda_analyzer fixes this issue.
I believe there should be some easy fix by initializing the codec with EAPD.
I myself can't commit a patch, because my C -kills suck ;)

i'd be really glad if someone could take a look at patch_via.c

regards
didi2002
