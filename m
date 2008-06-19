From: Rene Herman <rene.herman@keyaccess.nl>
Subject: 2.6.26-rc6 snd-pcsp: "Timer resolution is not
	sufficient"
Date: Thu, 19 Jun 2008 21:50:16 +0200
Message-ID: <485AB878.5080101@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E49A2446B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 21:49:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Stas.

What's this? 2.6.26-rc6:

===
input: PC Speaker as /class/input/input5
PCSP: Timer resolution is not sufficient (4000250nS)
PCSP: Make sure you have HPET and ACPI enabled.
PC-Speaker initialization failed.
pcspkr: probe of pcspkr failed with error -5
===

A HPET I do not have, ACPI is enabled and the driver worked fine on a 
previous -rc.

Rene.
