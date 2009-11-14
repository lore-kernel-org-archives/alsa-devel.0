From: Reiner <reiner1210@googlemail.com>
Subject: no sound when using TV-OUT - fixed
Date: Sat, 14 Nov 2009 11:30:20 +0100
Message-ID: <4AFE86BC.4010404@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id D601F24423
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 11:30:24 +0100 (CET)
Received: by bwz9 with SMTP id 9so10615990bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 02:30:23 -0800 (PST)
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

I think I have fixed it

in the /dev directory I have done the following:

chmod ugo+rw dsp

Now it works!
Sorry for the 3 e,ails but zo be honest: I dont't understand it, because
it's the same user !

Reiner
