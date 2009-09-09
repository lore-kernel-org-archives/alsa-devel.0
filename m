From: Nicolas Krieger <khenyh@gmail.com>
Subject: pts value using alsa for audio capture
Date: Wed, 9 Sep 2009 15:10:32 +0200
Message-ID: <3afeb4060909090610k370622c8w7fcee6ba850bbf03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id CFADE103840
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 15:10:52 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so1962544fge.2
	for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 06:10:52 -0700 (PDT)
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

I have a question about how pts are computed using alsa while grabbing
audio.
I take an example to explain :
I do grab audio during 10 seconds, the first 2 seconds, there is no problem,
so the pts are like that (I take examples values) : 1 2 3 4 5 6 .... x <- x
is the value of the last pts (2nd second).
Then, for any reason, no capture during 3 seconds. And then no problem until
the end.

Nicolas Krieger
