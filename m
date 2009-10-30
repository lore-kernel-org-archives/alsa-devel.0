From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] ASoC: remove io_mutex
Date: Fri, 30 Oct 2009 17:51:16 +0000
Message-ID: <20091030175116.GA27771@sirena.org.uk>
References: <1256902443-15492-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EDD872434B
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 18:51:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1256902443-15492-1-git-send-email-ext-eero.nurkkala@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-eero.nurkkala@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2009 at 01:34:01PM +0200, ext-eero.nurkkala@nokia.com wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> This RFC set addresses the existence of io_mutex.
> A safer method is introduced - but it changes the
> semantics quite a bit, as now all drivers calling

As discussed previously this is probably sensible; it's certainly more
sensible than the current code if nothing else.  I've applied them, if
there's problems we can fix them as they're noticed but this is a better
place to start from.  Thanks!

Please do always remember to CC maintainers on patches - it helps avoid
your patches getting lost.
