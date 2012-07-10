From: Christian Gruber <christian.gruber@voiceinterconnect.de>
Subject: Full duplex ALSA-plugin
Date: Tue, 10 Jul 2012 16:28:33 +0200
Message-ID: <4FFC3C11.4020600@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd14716.kasserver.com (dd14716.kasserver.com [85.13.136.34])
	by alsa0.perex.cz (Postfix) with ESMTP id B00362437B
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 16:24:42 +0200 (CEST)
Received: from server-a.vic.site (146-52-60-185-dynip.superkabel.de
	[146.52.60.185])
	by dd14716.kasserver.com (Postfix) with ESMTPSA id 3B21115CC02A
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 16:24:42 +0200 (CEST)
Received: from kepler.vic.site ([192.168.13.149])
	by server-a.vic.site with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <gruber@voiceinterconnect.de>)
	id 1SobMn-0003Ra-9I
	for alsa-devel@alsa-project.org; Tue, 10 Jul 2012 16:24:41 +0200
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

I was looking for information on writing an echo cancellation ALSA-plugin. So I studied 
the ALSA-plugin docs and also found several interesting threads in this mailing list. But 
what I found out, was quiet disillusioning.

If I understood the ALSA-plugin concept right, there is no possibility to write a plugin 
working on two streams, a playback and a record stream, simultaneously. One can only write 
a filter plugin, which works either on a playback stream or a record stream but not both. 
And there is no possibility to open a full duplex stream (consisting of playback and 
record) with snd_pcm_open().

Is there a reason, why full duplex streams are not implemented yet? Or is it planned in 
the future to implement this feature?

Regards,
Christian
