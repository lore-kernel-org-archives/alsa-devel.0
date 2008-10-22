From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Wed, 22 Oct 2008 21:57:30 +0100
Message-ID: <20081022205729.GD7537@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D06401037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 22:57:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FF7538.3090000@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 07:47:20PM +0100, Oliver Ford wrote:

> Setting it with alsamixer so it works and then using alsactl to save and 
> restore the config also breaks it.

> I'm not sure how to go about debugging this one, can anyone help?

Please send an alsactl save file with the offending configuration - I'll
try to reproduce (though possibly not before Monday).

Could you please also expand on "audio stops working" - for example, do
you get any diagnostics in dmesg, do applications appear to think they
are running normally, is there any noise at all (eg, static) and do any
other audio paths work?

> Also, is there a way to (and should I) set the DAC -> SPKMIX -> INV2 -> 
> OUT4 etc in my platform definition in the kernel code, rather than doing 
> it with amixer?

The recommended approach is to do this from user space.  Direct register
writes when probing should also do the trick if you want to do it
in-kernel but it's not so robust against future changes.
