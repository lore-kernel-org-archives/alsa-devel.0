From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Possible bug in alsa-lib.
 snd_pcm_hw_params_get_periods_max() returning 512 instead of 2.
Date: Thu, 10 Jun 2004 18:45:43 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406101844520.3148-100000@studcom.urz.uni-halle.de>
References: <40C6F9F2.6040203@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6B0B0226
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2004 18:45:51 +0200 (MEST)
In-reply-to: <40C6F9F2.6040203@superbug.demon.co.uk>
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
> If the application opens the device with "plug:front".
> That will print the message: -
> Periods range from 0 to 512
>
> I thought that this should have printed: -
> Periods range from 2 to 2

Try without "plug:".


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
