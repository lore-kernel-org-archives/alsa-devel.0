From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: amp power down event (resend with the
	correct	email)
Date: Tue, 10 Aug 2010 11:31:21 +0100
Message-ID: <20100810103120.GA4020@sirena.org.uk>
References: <4C604381.2080000@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C82024582
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 12:31:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C604381.2080000@gandalf.sssup.it>
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

On Mon, Aug 09, 2010 at 08:05:53PM +0200, Michael Trimarchi wrote:

> I'm t rying to unde rstand when the event a re called.

As I believe I have reminded you on a number of occasions you should
always CC the maintainers on Linux kernel queries.

> and receive the event => OFF. In the aplay example this happen
> afte r some seconds but in my application I don't receive the OFF
> event. What is w rong?

Your application will have left audio going to the speaker.  This will
either be a running playback or an analogue path.
