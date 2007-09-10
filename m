From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Unable to bypass alsa plugins and write directly
	to hw:0, 0
Date: Mon, 10 Sep 2007 15:42:55 -0400
Message-ID: <75b66ecd0709101242u139fd393xb4571d9e086c7972@mail.gmail.com>
References: <61445c750709101035s2030f02fv286501050aee16fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 35421103881
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 21:42:57 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1720449wag
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 12:42:55 -0700 (PDT)
In-Reply-To: <61445c750709101035s2030f02fv286501050aee16fb@mail.gmail.com>
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
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/10/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> My sound card supports hardware upsampling i.e. I do not need to use the
> software up sampling done by plugins like dmix etc. For testing hw up
> sampling, I tried to play an 8K sample rate wav file as follows, but some
> how it is being upsampled, I think I am missing something.

Your driver must not be setting the supported rates correctly.  Make
sure it contains 8K sample rate in the HW info structure.

Lee
