From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: Hiding unused CODEC mixer widgets in the
 machine driver
Date: Fri, 06 Aug 2010 12:34:13 +0100
Message-ID: <1281094453.3077.46.camel@odin>
References: <20100806001844.GM15884@atomos.longlandclan.yi.org>
	<20100806111935.GA31326@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F60A1039C5
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 13:34:15 +0200 (CEST)
Received: by wyb42 with SMTP id 42so7580653wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 04:34:15 -0700 (PDT)
In-Reply-To: <20100806111935.GA31326@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: tiwai@suse.de, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-06 at 12:19 +0100, Mark Brown wrote:
> On Fri, Aug 06, 2010 at 10:18:45AM +1000, Stuart Longland wrote:
> 
> > Work has continued on the TLV320AIC3204 CODEC driver, and there have
> > been a number of fixes since the last patch was published.  However,
> > this CODEC is a rather complicated beast to drive, some may find the
> > controls a little unweildy, and as such, I was wondering if the machine
> > driver could be used to abstract this for a given target?
> 
> The machine driver shouldn't be doing this - it's too fragile in the
> face of any changes in the drivers and means hard coding use cases into
> the kernel which is really bad practice since it's much slower than
> doing things from user space and much harder to change as new needs
> arise.
> 
> Much of this should be being handled by use case management anyway, even
> the controls that actually exist usefully on a given system are normally
> way more detail than end applications should ever be seeing.  See
> 
> 	http://www.slimlogic.co.uk/?p=40
> 
> for the API which should deal with that.  
> 

Please do give UCM (Use Case Manager) a test drive. We are in the late
development / early testing phase before upstreaming (still one or two
things todo).

You will need to checkout the use-case-verb branches of :-

git://git.slimlogic.co.uk/alsa-lib.git

git://git.slimlogic.co.uk/alsa-utils.git

There is a tool called alsaucm that allows changing the use case from
the command line. Best to use it's interactive (-i) mode atm.

There is also an initial repository for UCM use case configuration files
here :-

git://git.slimlogic.co.uk/alsa-ucm-conf.git

This will show the format required to describe use cases.

Thanks

Liam 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
