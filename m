From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Newbie: Broken pipe on snd_pcm_start
Date: Mon, 22 Nov 2004 18:34:23 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411221832500.12292-100000@studcom.urz.uni-halle.de>
References: <200411201833.52248.GregorMueckl@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411201833.52248.GregorMueckl@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregor =?iso-8859-1?q?M=FCckl?= <GregorMueckl@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gregor Mückl wrote:
> I tried to use snd_pcm_start() but this fails immediately with a
> broken pipe error message. Should this actually tell me that a
> buffer underrun happened?

Yes, calling snd_pcm_start() on an empty buffer will underrun
immediately.

> Although snd_pcm_prepare() is not reporting any errors, the sound
> won't play if I write it out using snd_pcm_writei().

Set start_threshold.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
