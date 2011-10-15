From: "Christian Hoff" <Christian_Hoff@gmx.net>
Subject: Creative X-Fi 51 Pro Support
Date: Sat, 15 Oct 2011 16:16:45 +0200
Message-ID: <20111015141645.203040@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id BA61024593
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 16:16:47 +0200 (CEST)
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

Dear all,

I just bough and installed a new Creative X-Fi 51 Pro USB sound card. The card works, but it recognized as a full speed 1.1 device instead of high speed (usb 2.0). This causes some limitations - for example I cannot play  5.1ch 24bit/96000Hz audio streams, but only 5.1ch 16/44000Hz.

 There are various other reports of this behavior in the net(for example [1]), but so far nobody was able to come up with a solution.

I would like to fix this in ALSA - probably some kind of vendor-specific quirk is needed which tells the card that it can safely turn on its high-speed capabilities. My assumption is that Creative just disabled the USB high speed features by default because some other OS'es might have problems with audio class 1 devices running at high speed.

Now what I would need is some sort of technical input from Creative. A technical documentation of the card or some sample code would be nice. Maybe they are going to send me the specs for their X-Fi 51 Pro if I ask, but the problem is whom at Creative should I ask?

Or is there anyone who already has some technical docs for that card available? The reason why I ask is because e.g. the remote control quirks would have required some docs from Creative, so I assume Creative has been sending you technical input in the past.

Thank you very much for any help on that matter.


Regards,

Christian Hoff

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/798795/comments/4
-- 
Empfehlen Sie GMX DSL Ihren Freunden und Bekannten und wir
belohnen Sie mit bis zu 50,- Euro! https://freundschaftswerbung.gmx.de
