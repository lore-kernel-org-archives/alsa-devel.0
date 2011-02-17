From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Thu, 17 Feb 2011 13:48:18 +0200
Message-ID: <4D5D0B02.9030002@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>	<8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<20110215102833.0727ef53.jhnikula@gmail.com>	<8CD9B447BF02D2F-DE8-B4B6@web-mmc-d01.sysops.aol.com>	<8CD9C6D5C822217-13C8-4CCF@web-mmc-d06.sysops.aol.com>
	<20110217101723.b272f4e4.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 9586824133
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 12:48:23 +0100 (CET)
In-Reply-To: <20110217101723.b272f4e4.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, ylin@mail.com
List-Id: alsa-devel@alsa-project.org

On 02/17/11 10:17, ext Jarkko Nikula wrote:
> Thanks, this is very good information and seems to indicate the same
> problem must be in upstream also as I don't recall that there were any
> other swapping related fixes than those that fix the playback case.

This is the first time I have heard of channel swapping related to
capture on OMAP platforms.
In playback case we can still have corner cases, when channels would
swap/shift, but in capture?
The only thing that I can think of is FIFO overflow, when odd number of
word got discarded, so from application point the channels would swap.

-- =

P=E9ter
