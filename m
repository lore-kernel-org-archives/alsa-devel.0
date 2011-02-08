From: Aleksandar Kostadinov <akostadinov@gmail.com>
Subject: list *all* PCMs
Date: Tue, 8 Feb 2011 21:25:03 +0200
Message-ID: <AANLkTikfPkpxshmJRVd_iHdNNddrM7LOT0cn+oTLGgtX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AB8F103828
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 20:25:03 +0100 (CET)
Received: by wyi11 with SMTP id 11so5980049wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Feb 2011 11:25:03 -0800 (PST)
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

I searched through the list archive and I can't find a way to list all
PCM devices. aplay/arecord -L show only these that have hint show on.
Is there such command that lists all PCMs?

While on it, it is also hard to obtain a list of capabilities of a
device. For example I don't see a way user can obtain the supported
sample rates by a sound device. I have found a program (see it
attached to http://www.spinics.net/linux/fedora/alsa-user/msg07230.html)
that seems to work fine. Could that program or similar functionality
be implemented in arecord/aplay so user can easily check device
capabilities?

Thank you,
Aleksandar

P.S. please cc me in replies because I'm not a subscriber
