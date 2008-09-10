From: Andreas Messer <andi@bupfen.de>
Subject: bug in snd_device_name_hint
Date: Wed, 10 Sep 2008 21:16:21 +0200
Message-ID: <48C81D05.4040309@bupfen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from login.domainpaket24.de
	(static.2.21.47.78.clients.your-server.de [78.47.21.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 90D6524348
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 21:17:06 +0200 (CEST)
Received: from [91.36.96.160] (p5B2460A0.dip.t-dialin.net [91.36.96.160])
	by login.domainpaket24.de (Postfix) with ESMTP id 13764645849
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 21:17:23 +0200 (CEST)
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

Hello,

at first I'm sorry for not using the bug-tracking system to report this 
bug. But I'm not going to create one account for each os-project only to 
submit a bug report.
While playing arround with mumble, I discovered a bug in the alsa 
library (1.0.17a) function 'snd_device_name_hint': Calling this function 
leads to a partial destroyed snd_config for my configuration. In my 
case, after calling this function, an open request for certain pcm 
devices fails. If you need detailed information, feel free to contact me 
using my email adress. (I'm not subscribing the mailing list!)

I omitted my config here, to keep this mail short...

greetings
Andreas
