From: 6275 kson <6275.kson@gmail.com>
Subject: USB Audio device syncpipe error
Date: Wed, 8 Sep 2010 14:40:55 -0500
Message-ID: <AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E56710383A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 21:40:57 +0200 (CEST)
Received: by ywg8 with SMTP id 8so269801ywg.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 12:40:56 -0700 (PDT)
In-Reply-To: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>
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

I am working on a usb audio device and I'm having trouble getting it to show
up as an output device in Ubuntu's (10.4) sound preferences.  The device is
working well with other OS's.

My syslog shows this error.
'cannot submit syncpipe for urb 0, error -90: internal error'

If someone could help me diagnose the source of the problem I would
appreciate it very much.

Here are some more details.
The device operates at high speed but uses USB Audio Class 1.0.

The output endpoint is Isochronous asynchronous and I am using a feedback
endpoint with a 32ms polling interval.

The device works with Ubuntu when running at full speed. (Input and Output
show up in the sound preferences).
At High Speed only the Input shows up in the sound preferences.

>From my usb analyzer log I never see a request for the feedback endpoint
when running at HS, while I do see the request at FS.

Cheers,
