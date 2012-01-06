From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Not able to restart audio after hibernation
Date: Fri, 6 Jan 2012 15:25:09 -0800
Message-ID: <20120106232504.GA5070@opensource.wolfsonmicro.com>
References: <4F06D156.1020208@st.com>
	<20120106183203.GA2893@opensource.wolfsonmicro.com>
	<1325883273.18044.631.camel@razman.gruenet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 226A9244F0
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2012 00:26:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325883273.18044.631.camel@razman.gruenet>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev kumar <rajeev-dlh.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, tiwai@suse.de, "spear--sw-devel@lists.codex.cro.st.com" <spear--sw-devel@lists.codex.cro.st.com>, Armando VISCONTI <armando.visconti@st.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 12:54:33PM -0800, Tobin Davis wrote:
> On Fri, 2012-01-06 at 10:32 -0800, Mark Brown wrote:

> > Hibernation is not supported on ARM at all.  Is SPEAR not an ARM based
> > platform?

> It isn't?  Hibernate is supported on all systems to some level.  Essentially 
> the cpu is just halting all threads and saving state (cpu, memory, and device configs) to storage.

...and then restoring it later when we power on again.  It's this bit
that had been tricky.

> And I have a couple of arm development platforms here that would beg to
> argue with this statement.

Perhaps it's been supported since I last looked, but if it has there's a
*lot* of drivers for ARM based systems which need to be updated.
