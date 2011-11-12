From: Sam Hawkens <Sam.Hawkens@freenet.de>
Subject: SPDIF receiver with dynamically changing sample rate
Date: Sat, 12 Nov 2011 12:39:48 +0000 (UTC)
Message-ID: <loom.20111112T133210-522@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 339CE245F1
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 13:45:13 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RPCxL-0002Dj-3y
	for alsa-devel@alsa-project.org; Sat, 12 Nov 2011 13:45:11 +0100
Received: from g230066013.adsl.alicedsl.de ([92.230.66.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 13:45:11 +0100
Received: from Sam.Hawkens by g230066013.adsl.alicedsl.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 13:45:11 +0100
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

I want to do the following: write an application that has its input fed from an
SPDIF receiver without using sample rate conversion. The sample rate must not be
set by the application but must be defined by the SPDIF receiver's PLL. 

Is it possible to run the application continously with ALSA even if the sample
rate changes? If yes, how can the application notice the change in sample rate?

Regards
Sam
