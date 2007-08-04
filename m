From: Damon Chaplin <damon@karuna.eclipse.co.uk>
Subject: Problem with CME UF5 MIDI keyboard master volume slider
Date: Sat, 04 Aug 2007 11:34:50 +0100
Message-ID: <1186223690.3246.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mra04.ch.as12513.net (mra04.ch.as12513.net [82.153.254.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 0327110382C
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Aug 2007 12:35:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mra04.ch.as12513.net (Postfix) with ESMTP id 2577EC0339
	for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2007 11:35:26 +0100 (BST)
Received: from mra04.ch.as12513.net ([127.0.0.1])
	by localhost (mra04.ch.as12513.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 27582-01-65 for <alsa-devel@alsa-project.org>;
	Sat,  4 Aug 2007 11:35:25 +0100 (BST)
Received: from [192.168.0.3] (unknown [82.152.255.59])
	by mra04.ch.as12513.net (Postfix) with ESMTP id B73C3C0319
	for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2007 11:35:09 +0100 (BST)
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

I have a CME UF5 MIDI keyboard (USB), which mostly works fine with ALSA.

However if I move the Master Volume slider I stop getting MIDI events -
I have to disconnect the snd_seq port and reconnect it to get MIDI
events working again.

Any ideas what the problem is? Or how to track it down?


Also, I wanted to try the rawmidi test app, but what would the device ID
be?

Damon
