From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] fix bug 5579: invalid long long format
	specifier
Date: Tue, 24 Apr 2012 20:56:51 +0200
Message-ID: <4F96F773.8050203@canonical.com>
References: <4F968768.20102@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 52DEF244D4
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 21:00:24 +0200 (CEST)
In-Reply-To: <4F968768.20102@barfooze.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Spencer <maillist-alsa@barfooze.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/24/2012 12:58 PM, John Spencer wrote:
> the attached patch fixes an invalid long long format specifier issue (%L
> was used by mistake, which is the long double specifier).
> this lead to abort() on 64bit system, making some of the alsa-utils
> unusable.

Thanks very much for this patch! I'm trying to access the bug tracker 
but it seems to be down - could you explain a little where and how this 
bug manifests itself, if you have any good test case etc?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
