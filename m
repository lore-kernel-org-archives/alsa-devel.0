From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa fails to open plug:surround51
Date: Fri, 24 Jun 2005 09:11:35 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506240910160.23252-100000@studcom.urz.uni-halle.de>
References: <42BB74E8.4030006@jeppesens.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42BB74E8.4030006@jeppesens.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Jeppesen <karsten@jeppesens.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Jeppesen wrote:
> Xine will open default to play the dvd menu (2.0).
> Then it will issue a snd_pcm_close for that stream
>
> When it then tries to open plug:surround51 (for the movie)  then this
> call fails with resource busy.

Which sound card?

Could you check with strace whether the device (/dev/snd/pcmCxDyp)
really is closed?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
