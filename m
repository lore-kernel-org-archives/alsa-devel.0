From: Eliot Blennerhassett <linux@audioscience.com>
Subject: View alsa-lib plugins setup for any app?
Date: Tue, 21 Oct 2008 14:29:20 +1300
Message-ID: <48FD3070.7080406@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id AD939246C9
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 03:29:46 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K92009XWESWVC20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 21 Oct 2008 14:29:25 +1300 (NZDT)
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

Greetings,

running aplay -v will show the plugin chain setup.

/proc/asound/card/pcm/* shows hw and sw params for the card driver when 
in use by any app

Is there any way to show the alsa-lib plugin settings a-la aplay for an 
arbitrary application?

thanks

--
Eliot
