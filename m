From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC suspend/resume
Date: Tue, 12 Aug 2008 15:36:54 +0100
Message-ID: <20080812143629.GA16373@sirena.org.uk>
References: <g7s6b3$e79$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 78171243DB
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 16:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g7s6b3$e79$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 12, 2008 at 02:22:27PM +0000, Dmitry Baryshkov wrote:

> I'm trying to clean up spitz ASoC driver: I need to put some GPIO pins to low
> during suspend and restore them during resume. What is the most logical place
> to do that? I can't find any suitable suspend hook.

The machine driver has suspend and resume callbacks, as well as a bias
level callback which should be usable for the same purprose (force the
GPIOs low when bias is off and set up normally otherwise).  The suspend
and resume hooks can run either before or after the main ASoC
infrastructure suspends (the _pre and _post variants).
