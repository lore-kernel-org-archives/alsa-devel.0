From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Not able to restart audio after hibernation
Date: Fri, 06 Jan 2012 12:54:33 -0800
Message-ID: <1325883273.18044.631.camel@razman.gruenet>
References: <4F06D156.1020208@st.com>
	<20120106183203.GA2893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 63F3024479
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 21:54:37 +0100 (CET)
In-Reply-To: <20120106183203.GA2893@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev kumar <rajeev-dlh.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, tiwai@suse.de, "spear--sw-devel@lists.codex.cro.st.com" <spear--sw-devel@lists.codex.cro.st.com>, Armando VISCONTI <armando.visconti@st.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-01-06 at 10:32 -0800, Mark Brown wrote:
> On Fri, Jan 06, 2012 at 04:17:50PM +0530, Rajeev kumar wrote:
> 
> > While going through the suspend/resume implementation in the alsa
> > framework, get to know that feature to support hibernation is
> > missing.
> 
> Hibernation is not supported on ARM at all.  Is SPEAR not an ARM based
> platform?
It isn't?  Hibernate is supported on all systems to some level.  Essentially 
the cpu is just halting all threads and saving state (cpu, memory, and device configs) to storage.

And I have a couple of arm development platforms here that would beg to
argue with this statement.


-- 
Tobin Davis 

A door is what a dog is perpetually on the wrong side of.
		-- Ogden Nash
