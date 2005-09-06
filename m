From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Converting OSS ioctl's to ALSA API
Date: Tue, 6 Sep 2005 09:53:25 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509060950330.11382-100000@studcom.urz.uni-halle.de>
References: <33017.65.103.251.231.1125967798.squirrel@65.103.251.231>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <33017.65.103.251.231.1125967798.squirrel@65.103.251.231>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob Ingraham <bobi@netshel.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bob Ingraham wrote:
> what would be the equivalent of the OSS SNDCTL_DSP_SYNC ioctl?

snd_pcm_drain()

> SNDCTL_DSP_SETFRAGMENT

snd_pcm_hw_params_set_period_size()
snd_pcm_hw_params_set_periods()

> SNDCLT_DSP_GETOSPACE, SNDCTL_DSP_GETISPACE

snd_pcm_avail_update()


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
