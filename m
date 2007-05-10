From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Problem with ALSA Capture and Playback : start_delay
Date: Fri, 11 May 2007 00:09:08 +0530
Message-ID: <8d6898730705101139i473b8efag196569d8ff76ef18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 76617243DD
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 20:39:10 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so676302nzf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 11:39:09 -0700 (PDT)
Content-Disposition: inline
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

Why start_delay=1 for capture and start_delay=0 for playback

what this means

I have one app which does both capture and playback, but when i tried
to read ALSA buffer(capture) periodically it gives ALSa buffer
overflow error.
what my app does is read from ALSA (capture mic) and write to ALSA(playback).

In this case for both Capture and Playback setting i am using start_delay = 0.


But if i am giving some delay between Read and Write no overflow error happens

Any idea why this happens

Thanks
