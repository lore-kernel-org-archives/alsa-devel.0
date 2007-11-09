From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoc] TDM over one SSC channel on AT91 possible?
Date: Fri, 09 Nov 2007 12:54:29 +0000
Message-ID: <1194612869.3180.412.camel@localhost.localdomain>
References: <4734465C.4020900@scottygroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 6946D243D2
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 13:54:30 +0100 (CET)
Received: from [10.0.2.101] (lrg2.demon.co.uk [80.176.148.77])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by opensource.wolfsonmicro.com (Postfix) with ESMTP id AE261D805C
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 11:52:02 +0000 (GMT)
In-Reply-To: <4734465C.4020900@scottygroup.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-11-09 at 12:37 +0100, Friedrich Lobenstock wrote:
> Hello!
> 
> The background:   I'm just designing an ATMEL AT91RM9200 based board which
>                   got two TLV320AIC33 on board. It is either possible
> to hook up the two TLV320AIC33 to a separate SSC (synchronous serial
> control) channel each or use one SSC channel and configure it for TDM (time
> division multiplex) mode. There is already a driver for
> TLV320AIC14k/TLV320AIC2k in the development tree, so adding support for the
> TLV320AIC33 should be feasible.
> 

Fwiw, TDM will save you a SSC port but will make similtanious use of
both codecs at different rates/formats difficult. It depends on your use
cases.

> What I'm not sure about is the fact if ASOC is prepared for using channels,
> especially SSC, in TDM mode. Is the core ASOC structure prepared to handle
> that?

It is for some platforms, but I think AT91 SSC and your codec will need
set_tdm_slot() implemented. Your machine driver will call set_tdm_slot
to configure codec/SSC slots.
 
> 
> Would we be better off instantiate one drive twice each time with different
> parameters for the SSC channel?
> 


I would instantiate one driver with 3 pcms. This would allow:-

pcm0: 2 channel, slot 0,1
pcm1: 2 channel, slot 2,3
pcm2: 4 channel, slot 0,1,2,3

Giving full flexibility for many use cases. The pcms would be mutually
exclusive (enforced by machine driver).

HTH

Liam
