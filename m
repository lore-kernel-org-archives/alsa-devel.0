From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: User-space OSS emulation?
Date: Thu, 8 Nov 2007 17:36:09 -0500
Message-ID: <75b66ecd0711081436g4b43cf5dl87114fa760e7b7b3@mail.gmail.com>
References: <47338EBD.2000206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 776ED243E3
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 23:36:10 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so240433rvb
	for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2007 14:36:09 -0800 (PST)
In-Reply-To: <47338EBD.2000206@freescale.com>
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

On Nov 8, 2007 5:33 PM, Timur Tabi <timur@freescale.com> wrote:
> Can someone tell me more about "user-space OSS emulation"?  I've read a few
> references to it in the mailing list archives, but a google search doesn't turn
> up anything useful.
>

Basically it uses LD_PRELOAD to redirect OSS API calls (ioctls) to the
alsa-lib equivalents.  man aoss for details on usage.

Lee
