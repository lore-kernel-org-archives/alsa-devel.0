From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Not important oops
Date: Thu, 22 Jan 2004 12:41:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401221236110.2314@pnote.perex-int.cz>
References: <200401211255.i0LCtroL006857@www1.pobox.sk> <s5h65f56t7b.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0401211945400.2010@pnote.perex-int.cz> <s5h3ca96scx.wl@alsa2.suse.de>
 <400F1978.4030901@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <400F1978.4030901@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Jan 2004, James Courtier-Dutton wrote:

> User application does VOL++.
> OSS has a range from 0-100
> ALSA uses hardware range of 0-31.
> THus: -
> OSS VOL=0
> OSS VOL++
> ALSA VOL stays at 0
> OSS READ VOL, = 0;

It should work. We have correction for this case in snd_mixer_oss_conv1(). 
Perhaps, the code has a bug somewhere. Can you write a small code which 
shows this bug for debugging?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
