From: Sam Hawkens <Sam.Hawkens@freenet.de>
Subject: Re: SPDIF receiver with dynamically changing sample
 rate
Date: Sun, 13 Nov 2011 04:53:13 +0100
Message-ID: <4EBF3F29.2090107@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout8.freenet.de (mout8.freenet.de [195.4.92.98])
	by alsa0.perex.cz (Postfix) with ESMTP id BBAF8246F0
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 04:55:30 +0100 (CET)
Received: from [195.4.92.140] (helo=mjail0.freenet.de)
	by mout8.freenet.de with esmtpa (ID Johannes.Gernemann@freenet.de)
	(port 25) (Exim 4.76 #5) id 1RPRAH-00061e-A2
	for alsa-devel@alsa-project.org; Sun, 13 Nov 2011 04:55:29 +0100
Received: from localhost ([::1]:43713 helo=mjail0.freenet.de)
	by mjail0.freenet.de with esmtpa (ID Johannes.Gernemann@freenet.de)
	(Exim 4.76 #1) id 1RPRAH-0001IE-6Q
	for alsa-devel@alsa-project.org; Sun, 13 Nov 2011 04:55:29 +0100
Received: from [195.4.92.24] (port=37079 helo=14.mx.freenet.de)
	by mjail0.freenet.de with esmtpa (ID Johannes.Gernemann@freenet.de)
	(Exim 4.76 #1) id 1RPR8D-0006Gs-UF
	for alsa-devel@alsa-project.org; Sun, 13 Nov 2011 04:53:21 +0100
Received: from g230068059.adsl.alicedsl.de ([92.230.68.59]:54565
	helo=[192.168.178.31])
	by 14.mx.freenet.de with esmtpa (ID Johannes.Gernemann@freenet.de)
	(port 25) (Exim 4.76 #1) id 1RPR8D-0006kb-Lt
	for alsa-devel@alsa-project.org; Sun, 13 Nov 2011 04:53:21 +0100
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

Am 12.11.2011 16:36, schrieb Clemens Ladisch:

> Most drivers ignore the rate requested by the application and return the samples
> as they come from the input.  Only the AK411* drivers monitor the rate and stop
> the stream on changes.
OK, so that should work.

>> If yes, how can the application notice the change in sample rate?
> This is usually not possible without measuring the rate at which samples arrive.
> However, you could check the declared rate of the sender by monitoring the
> channel status bits.
OK, so this could be a solution as long as the SPDIF stream carries correct channel stauts information (which is not alway the case). Still a good idea.
Some SPDIF receivers have an interrupt output that can be configured to be asserted when sample rate changes. With a custom hardware design that's another option in addition to the available ALSA features.

Thanx a lot for the good advice!

Regards,
Sam
