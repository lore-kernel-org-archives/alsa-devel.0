From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] asoc: restrict sample rate and size in
	Freescale MPC8610 sound drivers
Date: Mon, 28 Jul 2008 17:05:55 -0500
Message-ID: <ed82fe3e0807281505j48acedbaye49eac06a799e0c@mail.gmail.com>
References: <1217274070-10537-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by alsa0.perex.cz (Postfix) with ESMTP id BAF461037F9
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 00:05:56 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so3687567wra.24
	for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2008 15:05:55 -0700 (PDT)
In-Reply-To: <1217274070-10537-1-git-send-email-timur@freescale.com>
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
To: alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2008 at 2:41 PM, Timur Tabi <timur@freescale.com> wrote:
> The Freescale MPC8610 SSI device has the option of using one clock for both
> transmit and receive (synchronous mode), or independent clocks (asynchronous).
> The SSI driver, however, programs the SSI into synchronous mode and then
> tries to program the clock registers independently.  The result is that the wrong
> sample size is usually generated during recording.

Please ignore this version of the patch.  I just posted an improved
version, labeled "[PATCH v2]".

-- 
Timur Tabi
Linux kernel developer at Freescale
