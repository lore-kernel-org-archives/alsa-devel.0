From: Liam Girdwood <lrg@ti.com>
Subject: Re: Any patch for OMAP4 sound card on Linux 3.0.0-rc7?
Date: Tue, 2 Aug 2011 22:07:07 +0100
Message-ID: <4E3866FB.3060301@ti.com>
References: <1312307893.75375.YahooMailClassic@web161718.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3114F1038D9
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 23:07:14 +0200 (CEST)
In-Reply-To: <1312307893.75375.YahooMailClassic@web161718.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: "Neri, Ricardo" <ricardo.neri@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/08/11 18:58, hong zhang wrote:
> Team,
> 
> Linux 3.0.0-rc7 complains following for OMAP4 on Linux 3.0.0-rc7 during boot
> 
> SDP4430 SoC init
> Error: Driver 'hdmi-audio-dai' is already registered, aborting...
> 
> Any patch available for the error or where I can look at?

Looks like the device is being registered twice. 

Fwiw, the OMAP4 HDMI audio driver has been separated from sdp4430.c. So sdp4430.c should not contain any HDMI code.

Liam 

> 
> Thanks.
> 
> ---henry
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
