From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Possible bug in alsa-lib.
 snd_pcm_hw_params_get_periods_max() returning 512 instead of 2.
Date: Fri, 11 Jun 2004 16:54:16 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406111651150.18177-100000@studcom.urz.uni-halle.de>
References: <40C9C104.4010909@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E8334283
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2004 16:54:18 +0200 (MEST)
In-reply-to: <40C9C104.4010909@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I cannot think of any circumstances where doing sample rate conversion
> (using the "plug:" plugin) would change the amount of periods.
> Is this a bug in the "plug:" plugin ?

Works as designed, I guess.  It's the job of the plug plugin to remove
hardware limitations, just in case an application wants to use 42
periods.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
