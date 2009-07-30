From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH] ALSA: Write outside array bounds
Date: Thu, 30 Jul 2009 11:57:04 +0100
Message-ID: <200907301157.04296.gineera@aspect135.co.uk>
References: <4A702387.8090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ttsmtp.cpwnetworks.com (ttsmtp-3.cpwnetworks.com
	[62.24.128.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 156881038DB
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 12:45:51 +0200 (CEST)
In-Reply-To: <4A702387.8090908@gmail.com>
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
To: Roel Kluin <roel.kluin@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 29 July 2009 11:25, Roel Kluin wrote:
> e->sad[] is declared with size ELD_MAX_SAD (16), but the guard allows
> the range 0-31
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Found with Parfait, http://research.sun.com/projects/parfait/

I've been looking for this tool to evaluate; is it available publically, or do 
you have 'privilaged access'?

Thanks

Alan
