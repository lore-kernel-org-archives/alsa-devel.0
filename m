From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Playing multiple sounds at the same time
Date: Fri, 30 Apr 2010 11:43:09 +0100
Message-ID: <20100430104308.GE21607@sirena.org.uk>
References: <4411e1854e5de844b0cf28262efd5992-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFJQQ1lcLkQAWFhfQltcWgE=-webmailer2@server02.webmailer.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 19108103910
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 12:43:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4411e1854e5de844b0cf28262efd5992-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFJQQ1lcLkQAWFhfQltcWgE=-webmailer2@server02.webmailer.hosteurope.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Falkenhahn <andreas@airsoftsoftwair.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 12:38:49PM +0200, Andreas Falkenhahn wrote:

> Now I want to play sounds 1 to 3 at the same time. My question is now: Can
> ALSA do automatic mixing for me here or do I have to do the mixing on my
> own? In other words, can I simply feed all these three sound streams to
> ALSA or do I have to mix them into a fourth audio stream first and feeding
> this new fourth stream to ALSA then?

The easiest thing for your application is to just open and play multiple
audio streams and allow a system mixing daemon such as PulseAudio to
take care of the mixing.
