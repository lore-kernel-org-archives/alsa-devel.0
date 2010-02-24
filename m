From: Nitin PAI <nitinmpai@gmail.com>
Subject: Listing virtual devices for a sound card (aplay -L)
Date: Wed, 24 Feb 2010 19:24:22 +0530
Message-ID: <e73559ba1002240554m22a1850o753497422954363b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f197.google.com (mail-px0-f197.google.com
	[209.85.216.197])
	by alsa0.perex.cz (Postfix) with ESMTP id E31ED10392B
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 14:54:24 +0100 (CET)
Received: by pxi35 with SMTP id 35so174032pxi.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 05:54:23 -0800 (PST)
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

I have added  proprietary sound cards which are statically compiled in the
kernel. Card 0: Name=X, Card 1: Name=Y.

I want to create virtual devices using these cards, like front,
left,surround,iec958.  I see that this is usually done at
/usr/share/alsa/cards/....

Please let me know how this mapping works?

I mean how does aplay -L  list these devices by mapping the sound card to
the ones in /usr/share/alsa/cards/...
I tried creating X.conf and Y.conf there with front,left,surroud,iec958, but
aplay -L doesnt seem to recognize them.

Also, I want  iec958 card to be one of the cards listed via aplay -L, and
defining this in asound.conf gives error with aplay.

Any help will be appreciated.

Thanks,
Nitin
