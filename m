From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: alsa driver api
Date: Thu, 03 May 2007 05:07:02 +0100
Message-ID: <46395FE6.7080803@superbug.co.uk>
References: <c88e466f0705021040p1166b247t864288e3355dc25c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa0.perex.cz (Postfix) with ESMTP id BFE90243EF
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 06:07:03 +0200 (CEST)
In-Reply-To: <c88e466f0705021040p1166b247t864288e3355dc25c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michel Benoit <murpme@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Michel Benoit wrote:
> Hi
> 
> Does anyone have some code examples that show how to send pcm samples
> directly to an alsa driver.  I'm (still) having trouble building/using
> alsa-lib and I want to make sure that my driver works correctly. If I
> understand correctly it is possible to send sound samples using the
> alsa driver api only (no alsa-lib).
> 
> All I want to do for now is send a fixed sine wave to the driver. I
> saw some code snippets that seemed to do just that in a recent email
> on this list but it would help a lot if I could have a look at the
> complete application.
> 
> Thanks,
> 
> Michel

There is an alsa tool already available to do the task.
It is called "speaker-test"
speaker-test -c2 -Dplug:front -twav    (voices)
speaker-test -c2 -Dplug:front -tsine   (sine wave)
speaker-test -c2 -Dplug:front -tpink   (pink noise)

You can then use any device name you wish to test.

James
