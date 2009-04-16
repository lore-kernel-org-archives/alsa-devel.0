From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: s3c-i2s-v2.c fix
	for	s3c_i2sv2_iis_calc_rate
Date: Thu, 16 Apr 2009 10:57:05 +0100
Message-ID: <20090416095705.GE16318@sirena.org.uk>
References: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-2-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-3-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-4-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-5-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BF1DB10396F
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:57:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239874343-7280-5-git-send-email-ben-linux@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 10:32:23AM +0100, Ben Dooks wrote:
> The definition of s3c_i2sv2_iis_calc_rate was never
> renamed from s3c2412_iis_calc_rate, so rename this
> to allow the build to work.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Applied, thanks.
