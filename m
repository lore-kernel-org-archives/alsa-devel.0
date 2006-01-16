From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Jackit-devel] Real-world reports on two
	Delta 1010LTs/ice1712 synched?
Date: Mon, 16 Jan 2006 15:07:23 -0500
Message-ID: <1137442044.19444.15.camel@mindpipe>
References: <20051224124823.GA4183@localhost.localdomain>
	 <20051224144548.GA4306@localhost.localdomain>
	 <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net>
	 <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net>
	 <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net>
	 <20051227130029.GB3770@localhost.localdomain> <43B1A8FA.8080408@nostar.net>
	 <20060116175652.GM28738@edu.joroinen.fi>  <43CBF383.3000807@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43CBF383.3000807@nostar.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Doug McLain <doug@nostar.net>
Cc: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>, John Rigg <j@sound-man.co.uk>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-01-16 at 14:26 -0500, Doug McLain wrote:
> I've been studying the ice1712 alsa driver closely over the past few 
> weeks, and comparing all relevent ice1712 control register values in 
> windows vs linux (in windows I got ahold of this nice program called 
> PCIScope, a dream for reverse engineering pci hardware!) and I think 
> (hope) the problem is in the init and configuration of the cs8427
> spdif transceiver.  There are differences in bit values on the
> ice1712's GPIO data register. So my two areas of concern are
> deciphering the usage of the GPIO register and the cs8427 spdif
> transceiver. The ice1712 talks to the cs8427 over I2C, which isnt as
> straightforward to read as regular i/o registers, so it's more
> studying ahead.  I am focusing on fixing spdif functionality, since
> the cs8427 datasheet is very clear about spdif operation.  I am hoping
> by fixing regular spdif functionality on the ship, word clock will be
> fixed too. We'll see. 

If you get stuck, SoftICE is also an incredibly useful tool for reverse
engineering Windows drivers.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
