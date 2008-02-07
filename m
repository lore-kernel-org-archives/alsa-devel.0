From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: PXA27x and AC97 reset bug
Date: Thu, 7 Feb 2008 01:10:55 +0000 (UTC)
Message-ID: <fodlqv$iet$1@ger.gmane.org>
References: <87ejbpheqk.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F866244AB
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 02:35:09 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JMvfK-0007Gz-PU
	for alsa-devel@alsa-project.org; Thu, 07 Feb 2008 01:35:02 +0000
Received: from ppp78-37-180-171.pppoe.avangarddsl.ru ([78.37.180.171])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2008 01:35:02 +0000
Received: from dbaryshkov by ppp78-37-180-171.pppoe.avangarddsl.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2008 01:35:02 +0000
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

Hi,

Robert Jarzmik wrote:

> I hope this subject wasn't previously discussed, as I couldn't find a
> trace ...
> 
> The basic question is : why can't the PXA27x reset the AC97 bus in front
> of an wm9713 ?

I have nearly the same problem here: pxa255, wm9712, sharp SL-6000 (tosa).
However resetting the codec in a loop sometime helps.

Any info would be appreciated.

> And more precisely, I'd like to know :
>  - are there any references to this bug (Intel note, mailing list ref,
>  ...) - is it a hardware bug on PXA27x side ? - is it a hardware bug on
>  wm9713 side ? - is there a known generic workaround (assuming GPIO113
>  is connected to wm9713
> reset line is not generic for me) ?
>  - is there a known platform where this bug does not happen ?

-- 
With best wishes
Dmitry
