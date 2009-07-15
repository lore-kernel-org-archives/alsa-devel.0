From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/06] Fix compilation warning for
 sound/soc/codecs/wm8400.c
Date: Wed, 15 Jul 2009 09:28:26 +0100
Message-ID: <20090715082826.GA8689@rakim.wolfsonmicro.main>
References: <20090715021826.4032.63752.sendpatchset@subratamodak.linux.ibm.com>
	<1247633018.2437.5.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B33C91037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 10:28:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247633018.2437.5.camel@ht.satnam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, alsa-devel@alsa-project.org, Subrata Modak <subrata@linux.vnet.ibm.com>, Takashi Iwai <iwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <erex@perex.cz>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 15, 2009 at 10:13:38AM +0530, Jaswinder Singh Rajput wrote:
> Hello Subrata,

> This kind of warnings born due to not handling the variables properly.
> Please try to understand the root cause of this warning, just shutting
> this warning is of no use.

...as I said last time you submitted rougly the same patch.  Please also
remember that sometimes these problems are false positives caused by
issues with the compiler flow analysis (as appears to be the case here).
