From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ess1688: fix OPL3 port setting
Date: Sun, 25 Jan 2009 23:05:55 +0100
Message-ID: <497CE243.5010400@gmail.com>
References: <20090125211031.32d37d66.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq3.tb.mail.iss.as9143.net (smtpq3.tb.mail.iss.as9143.net
	[212.54.42.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 228DB1037ED
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2009 23:06:19 +0100 (CET)
In-Reply-To: <20090125211031.32d37d66.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 25-01-09 21:10, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The ess1688 driver uses the same port
> for PCM audio (SB compatible) and OPL3
> synthesis. It is wrong so allow to
> choose a correct port for OPL3 synthesis.

Only a very quick reply -- generally, the low 2 SB ports are indeed OPL3 
compatible (or was it just OPL2? ...)

Rene.
