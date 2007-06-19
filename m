From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Tue, 19 Jun 2007 16:07:05 -0400
Message-ID: <75b66ecd0706191307m2a93ae4mdf9b1b6dd4ee425a@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 83A4324410
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 22:07:07 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1737925nzf
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2007 13:07:06 -0700 (PDT)
In-Reply-To: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
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
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/19/07, Paul Kavan <pkavan@gmail.com> wrote:
> I have managed to get the alsa-libs and aplay, arecord, and speaker-test on
> my board, but I am unsure how to get them to play. I have tried making the
> device nodes and am using a simple alsa.conf, but still no joy. I am sure
> there is something simple I am missing.

What does "strace aplay file.wav" output?

Lee
