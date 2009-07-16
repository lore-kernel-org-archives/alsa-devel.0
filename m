From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: Callbacks from opening or closing alsa streams
Date: Thu, 16 Jul 2009 14:00:41 -0700
Message-ID: <aceb60a00907161400q1f36f04bn7ca860186814e054@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id D58211037E3
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 23:00:42 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so163191qwf.56
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2009 14:00:41 -0700 (PDT)
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

I was wondering if it was possible to get callbacks from opening and closing
of alsa streams with the alsa sink name that was opened.

So if I have an asound.conf configured like so:

pcm.music {
    type hw
    card 0
}

Is it possible to get a callback saying that a stream on the "music" sink
was opened?

Thanks
Baek

-- 
Baek Chang
baeksan@ccrma.stanford.edu
