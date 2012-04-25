From: John Spencer <maillist-alsa@barfooze.de>
Subject: Re: [PATCH] fix bug 5579: invalid long long format
	specifier
Date: Wed, 25 Apr 2012 19:21:31 +0200
Message-ID: <4F98329B.5060605@barfooze.de>
References: <4F968768.20102@barfooze.de> <4F96F773.8050203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 021BA1049E8
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 19:16:21 +0200 (CEST)
In-Reply-To: <4F96F773.8050203@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/24/2012 08:56 PM, David Henningsson wrote:
> On 04/24/2012 12:58 PM, John Spencer wrote:
>> the attached patch fixes an invalid long long format specifier issue (%L
>> was used by mistake, which is the long double specifier).
>> this lead to abort() on 64bit system, making some of the alsa-utils
>> unusable.
>
> Thanks very much for this patch! I'm trying to access the bug tracker 
> but it seems to be down - could you explain a little where and how 
> this bug manifests itself, if you have any good test case etc?
>
it manifests itself when a POSIX compliant C library is used (i.e. not 
glibc).
musl libc's snprintf will return an error by detecting the invalid 
combination %Li

err = snprintf(res, sizeof(res), "%Li", config->u.integer64);


thus the following code is triggered

  			if (err<  0 || err == sizeof(res)) {
  				assert(0);
  				return -ENOMEM;

however, depending on how stdarg is implemented, a buggy implementation 
could eventually try to load a double from the floating point stack, 
instead of using the stack/integer registers, thus causing a crash, 
which would be even worse.
