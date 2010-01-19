From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: About audio driver architecture
Date: Tue, 19 Jan 2010 11:50:51 +0000
Message-ID: <20100119115050.GA24755@sirena.org.uk>
References: <f74f98341001182326s1c03d5e2va470207ff194c2ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 28D25103859
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 12:50:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f74f98341001182326s1c03d5e2va470207ff194c2ad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Qiu <fallwind@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2010 at 03:26:06PM +0800, Michael Qiu wrote:

> 1. Seems the "ALSA Driver Documentation" is mainly for PCI(and for PC)
> based audio card. Where can I got a document for SOC which has no PCI
> bus. If there are some existing drivers it will be even better.

If this is for an embedded system (sounds like it when you're talking
about SoCs) then there's an entire subsystem for it under sound/soc with
some documentation under Documentation/sound/soc

> 2. Is there any standard for such a audio driver which upper
> applications will depend on it? Or I can just follow ALSA?

Use ALSA.
