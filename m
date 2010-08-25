From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Loopback device conf/alias
Date: Wed, 25 Aug 2010 11:13:54 -0500
Message-ID: <AANLkTik5EgcN+RirO2TnyfUytVvXmx9roY8s=rHVZy6x@mail.gmail.com>
References: <AANLkTimpA7QjU0w+EO0Ky_k-zZpB4Y4h2hGHu7mZn=bL@mail.gmail.com>
	<alpine.LNX.2.00.1008250845380.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 184B12468F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 18:13:55 +0200 (CEST)
Received: by iwn4 with SMTP id 4so713182iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 09:13:55 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008250845380.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Use 'hw:Loopback' device or assign any other car ID string as the module
> parameters (id=<your_string>) or you may change the card ID string at
> runtime using 'echo <your_string> > /sys/class/sound/card1/id', replace
> card1 with the loopback card index (this way may be used in udev scripts
> where you can check the module name (snd_aloop) as well).

Works fine. Thanks for the tip.
-Pierre
