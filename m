From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to
 new-style i2c drivers
Date: Wed, 15 Apr 2009 10:19:36 +0200
Message-ID: <20090415101936.7f6d720e@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
	<m2prfe26on.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 872252434A
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 10:20:02 +0200 (CEST)
In-Reply-To: <m2prfe26on.fsf@igel.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, Benjamin@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Apr 2009 00:48:08 +0200, Andreas Schwab wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> 
> > Hi Johannes,
> >
> > On Tue, 14 Apr 2009 19:41:55 +0200, Johannes Berg wrote:
> >> Alright, with the patch Andreas pointed out it loads, but segfaults, as
> >> below. Works fine without your patch.
> >
> > Thanks for the quick test and sorry that it didn't work. I'll take a
> > look at the trace below and try to figure out what went wrong.
> >
> > Did you remove the 2 MODULE_DEVICE_TABLE from my patch? If you didn't,
> > please pick the latest version of my patch which doesn't have them:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/sound-aoa-codecs-convert-to-new-style.patch
> > I don't think they are the reason of the crash, but who knows...
> 
> I tried with a tas-based iBook, and it works fine here.

Good news, thanks Andreas!

-- 
Jean Delvare
