From: Paul Davis <pbd@op.net>
Subject: Re: dir parameter
Date: Thu, 18 Jul 2002 13:22:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207181720.TAA10994@alsa.alsa-project.org>
References: <3D36EF6F.5FF4DED6@t-online.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA10994
	for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2002 19:20:37 +0200
In-Reply-To: Your message of "Thu, 18 Jul 2002 18:40:15 +0200."
             <3D36EF6F.5FF4DED6@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: FAU <Frank.Uepping@t-online.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>some functions take an int parameter called dir (e.g.:
>snd_pcm_hw_params_set_rate()).
>What is the meaning of that parameter?

its to let you know if the actual value set is above, below or equal
to the one you asked for.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
