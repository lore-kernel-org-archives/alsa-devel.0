From: =?iso-8859-1?Q?Marco_Bn=E0?= <bna.marco@gmail.com>
Subject: How to capture audio stream written on devices
Date: Mon, 17 Sep 2007 23:49:51 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOnOVOXvXjhAoU6KIGCcPyfCgAAAEAAAAC30Ofpu01ZCof6EToho/Y0BAAAAAA==@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id E63BB243D1
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 23:49:56 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so22767ugf
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 14:49:56 -0700 (PDT)
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

Hi. I would like to capture the audio stream that is written on a device.
For example in OSS I will have to redefine ioctl() and some others
functions. What I have to do to capture audio streams using ALSA? And for
example sending them via a socket while capturing?

I have to specify that I cannot use JACK, I have to capture audio before it
is written on dev/abc.

 

Best regards,

 

Marco
