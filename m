From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 15:49:19 +0000
Message-ID: <20100216154919.GC10586@sirena.org.uk>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D39D24334
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 16:49:20 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1NhPfr-0000Ae-VA
	for alsa-devel@alsa-project.org; Tue, 16 Feb 2010 15:49:19 +0000
Content-Disposition: inline
In-Reply-To: <20100216154015.GA612@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2010 at 04:40:16PM +0100, Lennart Poettering wrote:

> Now, what Jaroslav listed above suggests that he chose carefully where
> he put 0dB. I was just wondering about that. Jaroslav, how did you
> choose where to put 0dB?

FWIW all the drivers I do take whatever the datasheet says the
gain/attenuation range is for the control in question.  For most modern
embedded CODECs there will be multiple user controllable gains in the
path.

We really need to get an API for exposing path information to userspace
to fully describe what's going on here.
