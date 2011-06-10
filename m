From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] ASoC: Add
	ADAU1701 codec driver
Date: Fri, 10 Jun 2011 19:57:09 +0200
Message-ID: <4DF25AF5.6070909@metafoo.de>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<BANLkTimLAfEj+tgNMWjTsanccgfEt9UW1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id A1954103D14
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 19:58:03 +0200 (CEST)
In-Reply-To: <BANLkTimLAfEj+tgNMWjTsanccgfEt9UW1g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/10/2011 07:43 PM, Mike Frysinger wrote:
> On Fri, Jun 10, 2011 at 13:18, Lars-Peter Clausen wrote:
>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> 
> did you actually rewrite this thing from scratch ?  seems like you
> should keep Cliff as the author in git/MODULE_AUTHOR, and then add
> your name to the s-o-b list and this macro.

Not from scratch, but I guess except for the register definitions and the
copyright header not much of the original driver is left:
sound/soc/codecs/adau1701.c |  662 ++++++++++++++++++++++++-------------------
 1 files changed, 371 insertions(+), 291 deletions(-)



> 
> friendly git commits can easily be cherry picked from my tree for asoc stuff:
> http://git.kernel.org/?p=linux/kernel/git/vapier/blackfin.git;a=summary
> (see the "trunk" branch)
> -mike
