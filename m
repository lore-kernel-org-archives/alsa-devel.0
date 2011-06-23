From: Julian Sikorski <belegdol@gmail.com>
Subject: model needed for Clevo P150HM (Realtek ALC892)
Date: Thu, 23 Jun 2011 08:36:55 +0200
Message-ID: <itumu8$r5k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FED424548
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 08:40:12 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QZdaA-0004Ys-3P
	for alsa-devel@alsa-project.org; Thu, 23 Jun 2011 08:40:06 +0200
Received: from 178-83-206-189.dynamic.hispeed.ch ([178.83.206.189])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 08:40:06 +0200
Received: from belegdol by 178-83-206-189.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 08:40:06 +0200
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

Hi,

I am coming here from pulseaudio-general mailing list [1]. I recently
got myself a Clevo P150HM laptop. It has 2.1 speakers, a built-in
microphone and the following connectors:
- headphone out
- microphone in; can be switched to center/lfe out
- spdif out; can be switched to rear speaker out
- line in; can be switched to side speaker out
Alsa does not seem to reflect that the device is capable of 5.1 and 7.1
sound, and there are two configs showing up in pavucontrol (analog
output and analog headphones) which seem to be the same. I have uploaded
the output of alsa-info.sh [2]. Please let me know if more information
is needed.

Regards,
Julian

[1] http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/10096
[2]
http://www.alsa-project.org/db/?f=7c91e874f4272387c2c51e448337567202c0edfe
