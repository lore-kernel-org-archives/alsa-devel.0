From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: suspicious bug report
Date: Mon, 7 Mar 2005 17:24:15 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503071720530.27740-100000@studcom.urz.uni-halle.de>
References: <1110057285.12513.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110057285.12513.25.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> Does anyone know what to make of this bug?
>
> http://bugme.osdl.org/show_bug.cgi?id=4282

This function (snd_mixer_oss_build_inputs) showed up in a similar bug
report (that I can't find now) with the snd-azx driver.

I then fixed a forgotten semaphore release in this function, but it
wasn't related to the oops.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
