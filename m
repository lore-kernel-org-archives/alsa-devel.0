From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 9 Nov 2007 15:30:28 -0500
Message-ID: <75b66ecd0711091230v64cbc822kb65c93709e1e8e81@mail.gmail.com>
References: <472E5A64.6010705@aknet.ru> <4732C455.7040503@aknet.ru>
	<s5hd4ulthy3.wl%tiwai@suse.de> <473488CA.7050308@freescale.com>
	<4734A448.7000909@aknet.ru> <4734BA93.6040900@freescale.com>
	<4734BC5F.8040800@aknet.ru> <4734BDD1.9080103@freescale.com>
	<75b66ecd0711091211o9e1297em391d7091c5d51931@mail.gmail.com>
	<4734C036.3060301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id C99D024422
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 21:30:31 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so453775rvb
	for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2007 12:30:28 -0800 (PST)
In-Reply-To: <4734C036.3060301@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 9, 2007 3:16 PM, Timur Tabi <timur@freescale.com> wrote:
>
> mplayer -v -ao oss Cars480_1\[1\].5M.divx
>
> This movie has audio encoded at 44100KHz, and that's what causes the underrun
> problem.  I've been following this thread, but I'm still not sure what the
> solution is, if any.

There's your problem.  The in-kernel OSS emulation bypasses ALL of
alsa-lib including plugins and config files.

Lee
