From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: how to mandate the use of PCM plugin?
Date: Mon, 27 Sep 2010 18:40:56 +0400
Message-ID: <4CA0ACF8.9000405@aknet.ru>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru>
	<20100927055438.GA13129@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 97D2824417
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 16:40:58 +0200 (CEST)
In-Reply-To: <20100927055438.GA13129@opensource.wolfsonmicro.com>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  27.09.2010 09:54, Mark Brown wrote:
 > Why not work on fixing the actual problem if it's not already been fixed?
 > I'm not clear from your description what that actually is but it 
would seem
 > much more generally useful to fix that. This is far from the only 
card with
 > no hardware volume control and I'd imagine all will be affected.
I just checked with HDA-Intel, which seems to
have the softvol too, and no, it seems to communicate
fine with the pulseaudio volume. This is not the case
with snd-pcsp though, so indeed, there might just be
some bug. Btw, it is really very easy to test, everyone
has the snd-pcsp to reproduce that. :)
I'll post back when I have more info on what actually
breaks.
