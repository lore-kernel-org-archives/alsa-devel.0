From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] alsa-lib: Implements support for
 capture/playback enums.
Date: Sat, 14 Oct 2006 09:02:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610140859220.8569@tm8103.perex-int.cz>
References: <ALOGGER1160773600.5@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB6FB19E
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Oct 2006 09:02:50 +0200 (MEST)
In-Reply-To: <ALOGGER1160773600.5@alsa-project.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Oct 2006, James Courtier-Dutton wrote:

> +	{" Playback Enum", CTL_PLAYBACK_ENUM},
> +	{" Capture Enum", CTL_CAPTURE_ENUM},
> +	{" Enum", CTL_GLOBAL_ENUM},

I don't like this. We already know, that it's the enum type, so it's not 
required to put this type to control id name again.

Could you just check, if control id name ends with " Capture" or 
" Playback" words and set CTL_XXXX_ENUM according that?

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
