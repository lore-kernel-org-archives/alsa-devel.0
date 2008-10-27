From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Mon, 27 Oct 2008 10:42:26 +0000
Message-ID: <20081027104225.GA5896@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<20081010185312.GA10766@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
	<B9D3C48C98930741A166756A50C44A610F17B564@helx1.corp.vaisala.com>
	<20081014125835.GF14538@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B565@helx1.corp.vaisala.com>
	<49059097.5020309@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56B6C24522
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 11:42:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49059097.5020309@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: ext-jukka.hynninen@vaisala.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 27, 2008 at 10:57:43AM +0100, Sedji Gaouaou wrote:

> I am writing to know what is the current status about the at91/avr32 
> merging?
> Is there any progress concerning the testing?
> What is required for the patch to be accepted?

Jukka seemed happy but we've had no testing at all on AVR32 so far as
far as I can see - Geoffrey had been going to test it but his hardware
broke.  I'd say the best thing now -rc1 is out is to merge the patches
as-is and then fix up any further issues that are identified later.

The playpaq support will need a small refresh for the current machine
driver, though.
