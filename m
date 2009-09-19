From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Application and hw mixing for VoIP
Date: Sat, 19 Sep 2009 09:05:58 +0100
Message-ID: <20090919080558.GA4676@sirena.org.uk>
References: <001401ca377c$70fd20b0$52f76210$@comte@ercogener.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AF8A124503
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Sep 2009 10:06:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <001401ca377c$70fd20b0$52f76210$@comte@ercogener.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabien COMTE <fabien.comte@ercogener.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2009 at 11:51:33AM +0200, Fabien COMTE wrote:

> I have an application that does VoIP and use OSS emulated interface.

I suspect part of your problem here is the in-kernel OSS emulation -
that bypasses all the ALSA user space mixing support.  If you can't
change the OSS using application to use ALSA then I believe there are
some other options based on preloading a library to intercept the
attempts to open the OSS device and emulate it but I'm not really
familiar with them.
