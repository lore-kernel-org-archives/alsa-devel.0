From: Manuel Jander <manuel.jander@gmail.com>
Subject: ALSA default buffer sizes (recent now being subscribed
	with correct address... hopefully)
Date: Sat, 22 Aug 2009 22:47:14 +0200
Message-ID: <21ed1c370908221347w3b62b0ado7429382fc01945c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AE0B24371
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Aug 2009 22:47:15 +0200 (CEST)
Received: by fxm3 with SMTP id 3so934237fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2009 13:47:15 -0700 (PDT)
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

Hi there,

I'm somewhat upset because audacious does not work with my AU8830. The
problem is that audacious never calls any function that would give any
clue about the desired buffer size. So my AU8830 ends up with 32
periods, 1 byte each. Great ! I'm not going to blame the author of
that driver :P ... but:

The question is, who is the entity deciding those default values ?
Other soundcards seem to get reasonable defaults, but the AU8830 does
not. So I would like to fix that, but I want to do that at the right
place.

Best Regards, and many thanks for any hint.
