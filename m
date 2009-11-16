From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] move dereference after null check
Date: Mon, 16 Nov 2009 16:11:24 +0000
Message-ID: <20091116161124.GB29365@rakim.wolfsonmicro.main>
References: <alpine.DEB.2.00.0911151555010.12810@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5AC3B245B3
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 17:11:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0911151555010.12810@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2009 at 11:06:33AM +0200, Dan Carpenter wrote:
> The 'jack' variable was dereference before the NULL check so this patch 
> moves the dereference later.
> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

This does not apply to the current ASoC code, it appears that someone
else has already provided an equivalent change.  When doing work like
this it's normally best to work against -next to help avoid duplication
such as this.
