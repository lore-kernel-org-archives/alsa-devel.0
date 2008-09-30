From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia ETI-B1
	board
Date: Tue, 30 Sep 2008 16:11:01 +0100
Message-ID: <200809301611.01162.gineera@aspect135.co.uk>
References: <48E23AE0.3040805@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 871F82453E
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 16:58:18 +0200 (CEST)
In-Reply-To: <48E23AE0.3040805@endrelia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 30 September 2008 15:42, Frank Mandarino wrote:
> See attached.

I am a bit unclear about the implications of this, when it was first discussed 
and now there is a definite patch to remove eti_b1_wm8731.c

We based on this file to create an AT91<->wm8731 system; how is it proposed 
that the codec is glued to the board in the future?  Or is most of the code 
superfluous anyway?

Alan
