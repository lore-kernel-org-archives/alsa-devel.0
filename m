From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: An driver error when I using aplay!
Date: Mon, 07 Jun 2004 09:24:26 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de>
References: <20040607030408.4273.qmail@web15210.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040607030408.4273.qmail@web15210.mail.bjs.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?gb2312?q?Roc=20Wu?= <cooloney@yahoo.com.cn>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Roc Wu wrote:
> > # ./aplay -t wav -f U8 -r 22050 alarm.wav
> > Playing WAVE 'alarm.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono
> > ALSA lib pcm_plug.c:727:(snd_pcm_plug_hw_refine_schange)
> > Unable to find an usable access for 'default'
> > aplay: set_params:832: Sample format non available
> >
> > And the kernel driver will dump out the message as below:
> > Badness in aaci_pcm_close at sound/arm/aaci.c:404

This seems to be a bug in the sound driver.

However, arm/aaci.c is not part of the official ALSA distribution.
AFAIK it's a patch written by Russell King.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
