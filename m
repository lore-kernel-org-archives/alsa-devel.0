From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM format 20 bit
Date: Mon, 23 Oct 2006 10:27:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610231024310.9521@tm8103.perex-int.cz>
References: <B9FFC3F97441D04093A504CEA31B7C41EC8431@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1D62169
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Oct 2006 10:27:19 +0200 (MEST)
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41EC8431@msilexch01.marvell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Assaf Hoffman <hoffman@marvell.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Oct 2006, Assaf Hoffman wrote:

> Hi,
> The 20 bits are located in the low 20-bits of the 32-bit word (like
> SNDRV_PCM_FORMAT_x24_xE where the 24-bit sample is located in the low
> 24-bits in 32-bit word.

You are right. This format is not supported. If you add it, please, send 
us patches for driver and alsa-lib.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
