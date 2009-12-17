From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsa device drain power
Date: Thu, 17 Dec 2009 11:03:34 +0000
Message-ID: <20091217110334.GB12245@sirena.org.uk>
References: <4B29F03F.4020100@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 24C681038B4
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 12:03:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B29F03F.4020100@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 17, 2009 at 09:47:59AM +0100, Michael Trimarchi wrote:

> I have a simple question is the general behavior that an alsa device 
> start to drain power
> when it starts to play sound or start to recording. What happen if there 
> is an external amplifier
> connect to sound device?

In general any audio component is going to draw more power if there is a
signal going through it than if it's idle.  This is true regardless of
how the audio subsystem is split in terms of physical chips.

What are you trying to find out here?
