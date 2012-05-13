From: Mike Mestnik <cheako+alsa@mikemestnik.net>
Subject: hw/a52/dmix/other hardware plugins: paususpend option.
Date: Sat, 12 May 2012 22:13:14 -0500
Message-ID: <4FAF26CA.6070405@mikemestnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hades.mikemestnik.net (hades.mikemestnik.net [184.106.158.151])
	by alsa0.perex.cz (Postfix) with ESMTP id DECA42469B
	for <Alsa-devel@alsa-project.org>;
	Sun, 13 May 2012 05:13:17 +0200 (CEST)
Received: from arcadia.mikemestnik.net (unknown
	[IPv6:2001:470:1f11:9e9:a0ed:d874:ba3c:f7ef])
	by hades.mikemestnik.net (Postfix) with ESMTPSA id D1AC4D4549
	for <Alsa-devel@alsa-project.org>; Sat, 12 May 2012 22:13:15 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
  I've recently been working with the wine sound subsystem and there is
an increasing issue where PA prevents access to the hardware.  Now PA
already has a 'time out' to relinquish the hardware and this only serves
to confuse users as it's no-longer clear why "it" would work some times
but not others.

  Wine currently has a number of bugs with it's implementation of the
ALSA API and it's not likely that these will be worked on or even if the
work is done that it'll make it to become part of wine.  In short it
looks like the wine project has completely given up on supporting sound.

  Even so, I've requested that wine's alsa output module issue the
correct paususpend signals prior to accessing ALSA hardware.  However
it's non-trivial for an application to detect "If this ALSA driver
connects to PA?"  A way to query the 'features' needed by a specific
device string would be handy, keeping in mind that a device in ALSA can
be configured to pass through plugs, routes, and what not and still
eventually end up with the pulse plugin.

  Keeping on top of the entire issue, I believe that perhaps ALSA
plugins can also trigger paususpend.  I guess there biggest issue is not
to paususpend if being called as part of PulseAudio.  I believe that
this would be an important feature for every ALSA application, allowing
better integration with a vary popular Desktop sound server.

As I said, any plugin that attaches to direct hardware should attempt
discovery of needing to issue a paususpend.  Perhaps an option can be
added that the PA server should set to disable paususpend.

Thank you.
