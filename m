From: Mike Frysinger <vapier.adi@gmail.com>
Subject: getting dynamic state from ac97 bus ops
Date: Sun, 27 Mar 2011 22:48:52 -0400
Message-ID: <AANLkTinwMBTRkNyPWx+0=9ZY3+iWvadAevPe9J6BvNv2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1970C10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 04:50:16 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1820452fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2011 19:50:15 -0700 (PDT)
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

is there an obvious way that i'm missing to get at the bus state from
the funcs in the global soc_ac97_ops structure ?  the ac97 bus drivers
that i see in the tree simply have a global variable for state and
that sort of defeats the purpose of having multi-instance support in
the first place ...
-mike
