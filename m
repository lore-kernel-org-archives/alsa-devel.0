From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 9 Nov 2007 16:37:58 -0500
Message-ID: <75b66ecd0711091337m374f8b13ne4fae13818841502@mail.gmail.com>
References: <472E5A64.6010705@aknet.ru> <473488CA.7050308@freescale.com>
	<4734A448.7000909@aknet.ru> <4734BA93.6040900@freescale.com>
	<4734BC5F.8040800@aknet.ru> <4734BDD1.9080103@freescale.com>
	<75b66ecd0711091211o9e1297em391d7091c5d51931@mail.gmail.com>
	<4734C036.3060301@freescale.com>
	<75b66ecd0711091230v64cbc822kb65c93709e1e8e81@mail.gmail.com>
	<4734C402.1020004@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B2BF724339
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 22:37:59 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so462439rvb
	for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2007 13:37:58 -0800 (PST)
In-Reply-To: <4734C402.1020004@freescale.com>
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

On Nov 9, 2007 3:33 PM, Timur Tabi <timur@freescale.com> wrote:
> Lee Revell wrote:
>
> > There's your problem.  The in-kernel OSS emulation bypasses ALL of
> > alsa-lib including plugins and config files.
>
> Ok, now I'm confused.  Isn't this whole thread is about underrun problems with
> OSS?

Yes.  I don't know why anyone brought up ALSA config files.

Lee
