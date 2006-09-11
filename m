From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.18-rc6-mm1: endless loop in snd_hda_intel on
	HPC 6325, sometimes
Date: Mon, 11 Sep 2006 18:52:00 -0400
Message-ID: <1158015120.5076.228.camel@mindpipe>
References: <200609112220.04753.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DFEF5181
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Sep 2006 00:51:20 +0200 (MEST)
In-Reply-To: <200609112220.04753.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-09-11 at 22:20 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On the HPC 6325 I'm currently using snd_hda_intel sometimes goes into an
> endless loop in wich it plays the same chunk of sound (< 1 sec.) repeatedly
> forever.
> 
> It helps to reload the snd_hda_intel module.
> 

Does position_fix help?  See
Documentation/sound/alsa/ALSA-Configuration.txt.

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
