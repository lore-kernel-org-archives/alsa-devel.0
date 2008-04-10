From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: XRUN happens too often.
Date: Wed, 9 Apr 2008 21:01:53 -0400
Message-ID: <75b66ecd0804091801q1cf2d7fdq34a1b81048eb78d6@mail.gmail.com>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org> <47FB8D57.8030904@cox.net>
	<loom.20080409T051547-963@post.gmane.org> <47FD42F2.70903@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 55C7A10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 03:01:55 +0200 (CEST)
Received: by rv-out-0506.google.com with SMTP id g37so62203rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2008 18:01:53 -0700 (PDT)
In-Reply-To: <47FD42F2.70903@cox.net>
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
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org, Rong-Jhe <r93922118@ntu.edu.tw>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 9, 2008 at 6:28 PM, stan <ghjeold_i_mwee@cox.net> wrote:
>  That being said, if you are having underruns because of interrupt processing
>  time you are very close to the limit on your system.  I don't think that can
>  be it unless you are doing something like video processing at the time
>  you are
>  playing, or something like beagle or dbupdate is running (higher
>  priority tasks
>  than the sound card unless you have real time sound set).

Rong-Jhe,

If you aren't already, try using SCHED_FIFO priority for your audio thread.

Lee
