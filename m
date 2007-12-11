From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: cmipci: have only surround40 on 6 ch card
Date: Tue, 11 Dec 2007 09:43:28 +0100
Message-ID: <1197362608.17540.1225924713@webmail.messagingengine.com>
References: <fjcgls$55i$1@ger.gmane.org>
	<1197284022.25582.1225725951@webmail.messagingengine.com>
	<fjjr8a$ke9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id AF46A1038DF
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 09:43:29 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 243F577CBE
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 03:43:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <fjjr8a$ke9$1@ger.gmane.org>
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

SeNS wrote:
> You wrote  on Mon, 10 Dec 2007 11:53:42 +0100:
> 
>  CL> These registers identify the chip as model 37 with four channels.
>  CL> What model is this?
> 
> Chip should be this:
> http://www.cmedia.com.tw/files/doc/PCI/CMI8738_6ch_series_spec_v18f_registers.pdf

This is one of the datasheets that were used to write the driver, but
this .pdf is for chip version 55 which is identified by one bit in the
last byte of register 0c being set, which is not the case here:
0c: 00 00 01 00
             ^^

> CL> In what ALSA version did it work?
> 
> Unfortunatelly can't remember that :-( Some like 1.0.10RC3 (latest on the
> end of 2006).

This is strange; the 6ch-detection code hasn't changed in the last five
years.


Regards,
Clemens
