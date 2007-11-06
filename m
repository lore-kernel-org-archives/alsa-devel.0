From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Audio quality issues with dmix plugin
Date: Tue, 6 Nov 2007 13:46:51 +0530
Message-ID: <61445c750711060016y1755bd74l87cdc39718b5d226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A622247AC
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 09:16:54 +0100 (CET)
Received: by ro-out-1112.google.com with SMTP id h4so1693988roe
	for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2007 00:16:52 -0800 (PST)
Content-Disposition: inline
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

Hi,
When I play a 44Khz file without using any ALSA plugin like

#aplay -Dhw:0,0 44k.wav

the sound quality is awesome but when I play the same file using dmix,
clicks are introduced.

#aplay -Dplug:dmix 44k.wav

changing period size and buffer size doesn't help. I am testing my ALSA
driver on an OMAP850
based board.

Regards,
Pharaoh.
