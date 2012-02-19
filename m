From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Direct use of the DMA buffer?
Date: Mon, 20 Feb 2012 00:11:43 +0100
Message-ID: <4F4181AF.1060303@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 0C10B2463A
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 00:11:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id D6F7BA0247337
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 00:11:52 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4VaGzkViW4V for <alsa-devel@alsa-project.org>;
	Mon, 20 Feb 2012 00:11:47 +0100 (CET)
Received: from [192.168.105.101] (ip28.insite.cz [81.0.237.28])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id B81F4A024731D
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 00:11:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Please excuse my ignorance, but is it possible for an application to
directly use/output to the DMA buffer allocated by the kernel in
hw_params? Something like using the actual DMA buffer in the
snd_pcm_writei function, without copying the data in alsa-lib/driver PCM
midle layer (?), just managing the pointers.

Only a theoretical question though, no plans on my side :)

Thanks a lot for even a short No :-)

Best regards,

Pavel.
