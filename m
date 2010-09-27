From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Mon, 27 Sep 2010 01:58:58 +0100
Message-ID: <20100927005858.GD21247@sirena.org.uk>
References: <4C9F6409.6010400@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F0E0424638
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 02:58:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C9F6409.6010400@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 26, 2010 at 07:17:29PM +0400, Stas Sergeev wrote:

> Is it possible to somehow mandate the
> use of a PCM plugin? For example, the
> PC-Speaker.conf defines the use of softvol
> plugin for "default" and "front" devices.
> It is still possible for the software to bypass
> it by the use of "hw", and some software
> does exactly that.
> Is it possible to somehow make some
> plugin a mandatory?

What is the actual problem you are trying to solve here?  It's not
possible to *mandate* anything to all users, if nothing else someone
with administrative access can always rebuild whatever part of the
system is trying to restrict them.
