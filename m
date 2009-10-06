From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 0/3] ascenario: Bring it to compile after API
	changes.
Date: Tue,  6 Oct 2009 17:54:28 +0200
Message-ID: <1254844471-12987-1-git-send-email-stefan@datenfreihafen.org>
References: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C5E4243C4
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:54:46 +0200 (CEST)
Received: from p5b035e01.dip.t-dialin.net ([91.3.94.1] helo=excalibur)
	by sirius.lasnet.de with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1MvCNA-00073n-4q by authid <stefan@sostec.de> with cram_md5
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 17:54:46 +0200
Received: from stefan by excalibur with local (Exim 4.69)
	(envelope-from <stefan@excalibur.local>) id 1MvCNA-0003Q0-A2
	for alsa-devel@alsa-project.org; Tue, 06 Oct 2009 17:54:44 +0200
In-Reply-To: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
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

Just three small fixes to let the current ascenario branch at least compile.
Real stuff will come over the next days. Time to aall it a day now.

[PATCH 1/3] ascenario: Fix typedef for snd_scenario_t
[PATCH 2/3] ascenario: Fix usage of new typedefed snd_scenario_t
[PATCH 3/3] ascenario: Catchup with function declaration changes.

regards
Stefan Schmidt
