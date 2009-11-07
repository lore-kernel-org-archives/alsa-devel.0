From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: HDA timeouts
Date: Sat, 07 Nov 2009 21:08:42 +0200
Message-ID: <1257620922.5075.3.camel@maxim-laptop>
References: <1257620814.5075.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BDFC246A3
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 20:08:48 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so860476fgg.2
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 11:08:48 -0800 (PST)
In-Reply-To: <1257620814.5075.2.camel@maxim-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2009-11-07 at 21:06 +0200, Maxim Levitsky wrote: 
> Hi,
> 
> Sometimes (1 in 5 boots) I see the following:
> azx_get_response timeout, switching to polling mode: last cmd=0x014f0900
> 
> I initially blamed MSI that I enabled explicitly.
> If it is enabled, there is another timeout just before this line.
> Now I explicitly disable msi, and still see this.
> 
> It seems that codec hangs or so.
> 
> my codec#0 attached.
> 
> Best regards,
> Maxim Levitsky

I also filled a bugreport:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4796

Best regards,
Maxim Levitsky
