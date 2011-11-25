From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/8] firmware: Sigma: Skip header during
	CRC generation
Date: Fri, 25 Nov 2011 09:55:42 +0100
Message-ID: <4ECF580E.3060301@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
	<1322138908-32127-2-git-send-email-lars@metafoo.de>
	<201111241222.00189.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-169.synserver.de (smtp-out-169.synserver.de
	[212.40.185.169]) by alsa0.perex.cz (Postfix) with SMTP id 4AA3724421
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 09:54:48 +0100 (CET)
In-Reply-To: <201111241222.00189.vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 06:21 PM, Mike Frysinger wrote:
> On Thursday 24 November 2011 07:48:21 Lars-Peter Clausen wrote:
>> The firmware header is not part of the CRC, so skip it. Otherwise the
>> firmware will be rejected due to non-matching CRCs.
> 
> that's because you didn't compare to the right value ;).  include the CRC -> 
> compare to 0.  omit the CRC -> compare to the CRC value.

Does this really work if the CRC is inserted somewhere in the middle of the
bytestream?
