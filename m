From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: ALSA's jack reporting framework map to Android
 framework
Date: Mon, 14 Jun 2010 11:30:44 +0530
Message-ID: <98769532B4BB14429434178695419EAE042709C6EE@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE0426FF84AD@bgsmsx501.gar.corp.intel.com>
	<20100612170552.GA3110@sirena.org.uk>
	<AANLkTimTyqgo1Y5mDkUmnkaJEJr7HQfUjc43RJcXHxtm@mail.gmail.com>
	(sfid-20100612_233659_338867_1D688BB9)
	<DF126421-EAD3-4234-8E5E-7383FA1212CC@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 265A124643
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 08:00:50 +0200 (CEST)
In-Reply-To: <DF126421-EAD3-4234-8E5E-7383FA1212CC@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Lockwood <lockwood@android.com>, "swetland@android.com" <swetland@android.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mike,

Can you please CC your media team and so that we can discuss what is the right thing to do? 
Can we do a Android patch on the Android Framework to support ALSA's jack sensing? 
Is there any such effort already in progress from your media team?
Looks like modifying our audio drivers to support Android Framework is not recommended by the community. 

Thanks,
Harsha


> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Sunday, June 13, 2010 3:47 PM
> To: Mike Lockwood; swetland@android.com
> Cc: Harsha, Priya; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] ALSA's jack reporting framework map to Android
> framework
> 
> On 12 Jun 2010, at 23:36, Mike Lockwood wrote:
> 
> > There is no requirement to use the switch driver for the headset
> > detect.  At the time we did this we couldn't find an existing standard
> > and we had already written the switch driver for something else, so it
> > was an easy solution at the time.  But if there is something better
> > available now I don't see any reason not to use it.
> 
> In situations like this I'd always recommend discussing upstream - there
> may be something you've missed, or if there isn't then it means
> whatever you come up with can be adopted as a standard by everyone.
> 
> > I don't know what the current thinking is about ALSA and android -
> > someone on our media team would need to address that part of the
> > thread.  But if using ALSA requires GPL/LGPL code in userspace that
> > would probably be a deal breaker right there.
> 
> 
> Obviously there's already the option of using ALSA with the regular
> libraries (which are LGPLed) in Android which a bunch of vendors are
> using already - there's existing drivers for a range of CPUs and CODECs
> and many vendors are already shipping other Linux based OSs on their
> devices outside of Android which use things like the standard audio
> stack and so don't have a problem with LGPL in userspace.
> 
> Discussions with Brian Swetland (CCed in so he can correct me if I'm
> off base here) suggested that a direct to kernel option bypassing the
> standard libraries might be developed under a MITish license to provide
> as a default. This is obviously much less work than developing an entirely
> new audio stack would be, and unless plugins are in use the userspace
> portion is very thin.
