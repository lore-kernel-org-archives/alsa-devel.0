From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 3 Feb 2009 12:05:08 +0000
Message-ID: <20090203120504.GC23827@sirena.org.uk>
References: <200901271519.47119.anarsoul@gmail.com>
	<200902030146.38863.anarsoul@gmail.com>
	<20090203114136.GA23827@sirena.org.uk>
	<200902031357.12297.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA6E8103830
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 13:05:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200902031357.12297.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 01:57:12PM +0200, Vasily Khoruzhick wrote:

> Yep, I'm pretty sure. It will restore WSPLL bit if it was set before. It only 
> changes behavior of driver if SYSCLK was chosen. It seems that FIXMEs can be 
> removed, I can resubmit patch if you want.

Please do.  You should at least include some text in the patch
description explaining what you're doing.
