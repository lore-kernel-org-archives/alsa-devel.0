From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: ascenario: Small updates for new API.
Date: Wed,  7 Oct 2009 15:55:55 +0200
Message-ID: <1254923758-14598-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id C6C731038A0
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 15:56:04 +0200 (CEST)
Received: from p5b03679e.dip.t-dialin.net ([91.3.103.158] helo=excalibur)
	by sirius.lasnet.de with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1MvWzp-0002WG-3o by authid <stefan@sostec.de> with cram_md5
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 15:56:03 +0200
Received: from stefan by excalibur with local (Exim 4.69)
	(envelope-from <stefan@excalibur.local>) id 1MvWzp-0003o9-T7
	for alsa-devel@alsa-project.org; Wed, 07 Oct 2009 15:56:01 +0200
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

Hello.

[PATCH 1/3] ascenario: Rename SND_SCN_INT_QOS to SND_SCN_INT_QOS_POWER
As proposed by Jaroslav. Emphasis the power consumption relationship.

[PATCH 2/3] ascenario: Fix snd_scenario_get_control_id() declaration to match implementation
Just different names in declaration and implementation. I favoured
_control_id().

[PATCH 3/3] ascenario: Implement snd_scenario_get_control_id()
Replace the four explicit functions with a generic one. I was not able to find
another way to get the id from the given numid then getting the full list and
iterate through it. If there is something easier let me know. :)

regards
Stefan Schmidt
