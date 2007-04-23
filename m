From: "j t" <mark473@gmail.com>
Subject: What does start_threshold mean,
	and what value should it contain?
Date: Mon, 23 Apr 2007 11:27:31 +0100
Message-ID: <b88f52540704230327l6cd8baaele4fd54391b2dc3f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D2D52484A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 12:27:34 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1669321anc
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2007 03:27:31 -0700 (PDT)
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

Hi.

I'm trying to debug a problem with xruns which happen when playing a
wav file with vlc, but I can't reproduce the problems when using
"aplay -M" to play the same wav file. (logged as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3031).

I've checked the contents of /proc/asound/card0/pcm0p/sub0/ in both
cases - they appear to be very similar except for the contents of
sw_params: when I use vlc, start_threshold says 1, but when I use
"aplay -M", start_threshold says 16384.

So, what does start_threshold mean, is there a particular value that
start_threshold "should" contain, and could this difference be the
cause of the xruns? (The aplay man page doesn't seem to have any flags
for controlling the value of this parameter, so it doesn't appear to
be "user-configurable").

(Apologies if this is the wrong mailing list - I though that -devel
would be better than -user, but I could be wrong).

Thanks,

Jaime
