From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [RFC] Add scenario management
Date: Thu,  1 Oct 2009 11:47:14 +0200
Message-ID: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id AC388103829
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 11:47:48 +0200 (CEST)
Received: from c120.apm.etc.tu-bs.de ([134.169.174.120] helo=excalibur)
	by sirius.lasnet.de with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1MtIFz-0000oa-4g by authid <stefan@sostec.de> with cram_md5
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 11:47:44 +0200
Received: from stefan by excalibur with local (Exim 4.69)
	(envelope-from <stefan@excalibur.local>) id 1MtIFy-0001Nq-5E
	for alsa-devel@alsa-project.org; Thu, 01 Oct 2009 11:47:26 +0200
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

This patchset add support for scenario management, aka use cases, in alsa-lib
and example programs in alsa-utils. It allows to adjust the current audio kcontrol
settings from a prespective of a changed use case like the switch from listening
to music on your phone to an incoming phone call and back.

To achieve this it offers control aliasing for playback, capture master and
switch as well as the option to post- and prefix a sequence of control changes
avoiding pops and other unwanted noise.

This is of course not meant to replace gstreamer, PulseAudio or a sound server,
but is meant to work in tandem with such audio software. We think alsa-lib is
the best place for this as it will be used on small embedded system which only
use alsa from the full stack of audio libs in linux. We see potential for
desktop usage as well though.

There is also the support of QoS and the submission to salsa on the TODO list,
but we think it is best to gather soem feedback and get the core merged before
drifting away with to much other features.

Please let me know what can be improved.

Project page is here :-

http://www.slimlogic.co.uk/?p=40

regards
Stefan Schmidt
