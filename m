From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about your DSP topic branch
Date: Tue, 25 Jan 2011 11:51:13 +0000
Message-ID: <20110125115113.GB13051@sirena.org.uk>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 67BC61037E3
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 12:51:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D3E7536.9070906@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 24, 2011 at 11:01:10PM -0800, Patrick Lai wrote:

> 8. I see there is dmic codec(dmic.c) under sound/soc/codec which is 
> pretty much just a dummy codec driver. I supposed the configuration of 
> DMIC is done in other driver. Would it be better if we could have 

It's for direct DMIC interfaces in CPUs like OMAP4 has.

> something like fixed voltage regulator? So, there is no need to 
> duplicate the effort.

Yes, that'd be kind of nice but given how tiny these noop drivers are
and the fact that they do all need to specify their capabilites it's not
clear that there's much advantage from combining them into a single
driver - the boiler plate is so small and simple.
