From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA's jack reporting framework map to Android
	framework
Date: Sun, 13 Jun 2010 11:16:35 +0100
Message-ID: <DF126421-EAD3-4234-8E5E-7383FA1212CC@opensource.wolfsonmicro.com>
References: <98769532B4BB14429434178695419EAE0426FF84AD@bgsmsx501.gar.corp.intel.com>
	<20100612170552.GA3110@sirena.org.uk>
	<AANLkTimTyqgo1Y5mDkUmnkaJEJr7HQfUjc43RJcXHxtm@mail.gmail.com>
	(sfid-20100612_233659_338867_1D688BB9)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 831252439A
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Jun 2010 12:16:40 +0200 (CEST)
In-Reply-To: <AANLkTimTyqgo1Y5mDkUmnkaJEJr7HQfUjc43RJcXHxtm@mail.gmail.com>
	(sfid-20100612_233659_338867_1D688BB9)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Lockwood <lockwood@android.com>, swetland@android.com
Cc: alsa-devel@alsa-project.org, "Harsha, Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On 12 Jun 2010, at 23:36, Mike Lockwood wrote:

> There is no requirement to use the switch driver for the headset
> detect.  At the time we did this we couldn't find an existing standard
> and we had already written the switch driver for something else, so it
> was an easy solution at the time.  But if there is something better
> available now I don't see any reason not to use it.

In situations like this I'd always recommend discussing upstream - there
may be something you've missed, or if there isn't then it means
whatever you come up with can be adopted as a standard by everyone.

> I don't know what the current thinking is about ALSA and android -
> someone on our media team would need to address that part of the
> thread.  But if using ALSA requires GPL/LGPL code in userspace that
> would probably be a deal breaker right there.


Obviously there's already the option of using ALSA with the regular
libraries (which are LGPLed) in Android which a bunch of vendors are
using already - there's existing drivers for a range of CPUs and CODECs
and many vendors are already shipping other Linux based OSs on their
devices outside of Android which use things like the standard audio
stack and so don't have a problem with LGPL in userspace. 

Discussions with Brian Swetland (CCed in so he can correct me if I'm
off base here) suggested that a direct to kernel option bypassing the
standard libraries might be developed under a MITish license to provide
as a default. This is obviously much less work than developing an entirely
new audio stack would be, and unless plugins are in use the userspace
portion is very thin.
