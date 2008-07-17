From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [boot crash,
 bisected] in 9f240a55 "ALSA: opti93x: use cs4231 lib"
Date: Thu, 17 Jul 2008 21:38:09 +0200
Message-ID: <487F9FA1.7020101@keyaccess.nl>
References: <Pine.LNX.4.61.0807141105150.7676@tm8103-a.perex-int.cz>	<20080717170657.GA14593@elte.hu>
	<s5h3am8jqvy.wl%tiwai@suse.de> <487F9B9B.2010905@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 21A65243EA
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 21:36:10 +0200 (CEST)
In-Reply-To: <487F9B9B.2010905@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 17-07-08 21:20, Rene Herman wrote:

> On 17-07-08 20:40, Takashi Iwai wrote:
> 
>> Could you try the patch below?
> 
> No, please hang on, it's much simpler. Above commit isn't actually 
> itself guilty. Have a patch ready, but am testing a bit.

I retract that. Your patch should fix things.

I would like to place something on top to make the init isa/pnp choice 
look more generic but I'll submit that tomorrow.

Rene.
