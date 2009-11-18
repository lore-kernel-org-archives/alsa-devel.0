From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] move dereference after null check
Date: Wed, 18 Nov 2009 10:45:11 +0200 (SAST)
Message-ID: <alpine.DEB.2.00.0911181034370.27925@bicker>
References: <alpine.DEB.2.00.0911151555010.12810@bicker>
	<20091116161124.GB29365@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 8026A245F3
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 09:45:36 +0100 (CET)
Received: by bwz9 with SMTP id 9so2070028bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 00:45:35 -0800 (PST)
In-Reply-To: <20091116161124.GB29365@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dan Carpenter <error27@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Sorry about that.

I wish I could but until I get broadband, or git gets a restartable clone 
I can't use it for kernel development.  The kernel archive is too big to 
download in one shot.

Right now I pay $20 and I can use wifi for a week but it's capped out at 
200MB.  Fortunately, I'm likely to get broadband soon.  I'll pay $156 per 
month and it's capped at 200MB during business hours and "unlimitted" on 
nights and weekends.  Woohoo!

regards,
dan carpenter

On Mon, 16 Nov 2009, Mark Brown wrote:

> On Mon, Nov 16, 2009 at 11:06:33AM +0200, Dan Carpenter wrote:
> > The 'jack' variable was dereference before the NULL check so this patch 
> > moves the dereference later.
> > 
> > regards,
> > dan carpenter
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> This does not apply to the current ASoC code, it appears that someone
> else has already provided an equivalent change.  When doing work like
> this it's normally best to work against -next to help avoid duplication
> such as this.
> 
