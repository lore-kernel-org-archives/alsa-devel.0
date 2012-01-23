From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: alsa-utils-1.0.24.2 won't compile on x86_64 -
 CoreFoundation error
Date: Mon, 23 Jan 2012 12:15:52 +0200
Message-ID: <4F1D3358.2010701@pardus.org.tr>
References: <20120122211947.GA3594@localhost0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 361072447B
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 11:15:54 +0100 (CET)
Received: from [192.168.1.100] (unknown [81.214.87.249])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by lider.pardus.org.tr (Postfix) with ESMTPSA id E4223A7AAF7
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 11:58:36 +0200 (EET)
In-Reply-To: <20120122211947.GA3594@localhost0.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22.01.2012 23:19, John Rigg wrote:
> Apologies if this should have gone to alsa-user instead, but I've
> just tried compiling alsa-utils-1.0.24.2 on a Debian testing amd64 system,
> and configure gave a list of errors related to CoreFoundation.
> There were several similar to this in config.log:
> 
> ...
> configure:4589: checking for CFPreferencesCopyAppValue
> configure:4607: gcc -o conftest -g -O2   conftest.c  -Wl,-framework -Wl,CoreFoundation >&5
> conftest.c:11:42: fatal error: CoreFoundation/CFPreferences.h: No such file or directory
> compilation terminated.

Are you sure that the error is related to this? My configure&make
completes succesfully but in my config.log I have those lines too.
Actually they're normal tests to check for the availability of
CoreFoundation libraries.


-- 
Ozan Caglayan

Pardus Linux
http://www.pardus.org.tr/eng
