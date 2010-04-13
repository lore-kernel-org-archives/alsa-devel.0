From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: ALSA application programming: route audio from one PCM
	to another
Date: Tue, 13 Apr 2010 17:23:32 +0200
Message-ID: <4BC48C74.5010102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id DF7301037FF
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:23:40 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keymachine.tbmn.org (Postfix) with ESMTP id A8FB48AC5FB
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:23:38 +0200 (CEST)
Received: from keymachine.tbmn.org ([127.0.0.1])
	by localhost (keymachine.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZuO4Aqy4Njj for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:23:36 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by keymachine.tbmn.org (Postfix) with ESMTPSA id AF7698AC5FA
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:23:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I finally managed to write an ALSA I/O plugin that does what I want.
The plugin supports both playback and capture.

Now I would like to write a simple audio application that takes audio
samples

	* from the microphone and plays it back on my plugin
and
	* from the plugin (capture) and plays it back on the speakers


Hence as long as the application is running, it should do the above.

* Is there a special ALSA way to route audio from one PCM to another ?

* If not, I suppose it would just work if I open the plugin PCM and the
hw PCM at the same time and copy audio frames between them ?


cheers,
stefan
