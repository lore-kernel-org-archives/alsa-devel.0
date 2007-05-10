From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC PATCH] ASoC AC97/I2S for SH7760
Date: Thu, 10 May 2007 09:37:48 +0900
Message-ID: <20070510003748.GA25709@linux-sh.org>
References: <20070508174027.GB28884@roarinelk.homelinux.net>
	<20070509005255.GB19043@linux-sh.org>
	<20070509052503.GA32573@roarinelk.homelinux.net>
	<1178706319.3740.22.camel@a10072.wolfsonmicro.main>
	<20070508174027.GB28884@roarinelk.homelinux.net>
	<20070509005255.GB19043@linux-sh.org>
	<20070509052503.GA32573@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1178706319.3740.22.camel@a10072.wolfsonmicro.main>
	<20070509052503.GA32573@roarinelk.homelinux.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Manuel Lauss <mano@roarinelk.homelinux.net>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linuxsh-dev@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 09, 2007 at 07:25:03AM +0200, Manuel Lauss wrote:
> On Wed, May 09, 2007 at 09:52:55AM +0900, Paul Mundt wrote:
> > Platform device resources, please.
> 
> It's not that easy with asoc: first it does not pass any
> information to the ac97_read/write functions, and I haven't
> yet found a way to pass information from the probe() callbacks
> to the asoc core, hence this hack.
> In general, ASoC does not anticipate devices like the 7760 with
> 2 independent audio units.
>  

On Wed, May 09, 2007 at 11:25:19AM +0100, Liam Girdwood wrote:
> Fwiw, this is on my todo list for after the next merge. Sadly, I'm
> struggling for free time to add ac97 private data atm. 
> 

Given that, I don't have any other concerns about this particular patch.
The patch that this depends on is already merged for -rc1, so there
shouldn't be anything holding this up now.

When there's proper ac97 private data, it would be nice to redo these for
platform devices. In the meantime, we'll simply have to ifdef for all of
the CPU subtypes that might be able to leverage this..

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
