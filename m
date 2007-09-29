From: Stas Sergeev <stsp@aknet.ru>
Subject: nforce ac97 plays too fast
Date: Sat, 29 Sep 2007 11:52:08 +0400
Message-ID: <46FE0428.1070501@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E4CE2432E
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 09:52:14 +0200 (CEST)
Received: from ppp91-76-90-196.pppoe.mtu-net.ru ([91.76.90.196])
	by mail.aknet.ru with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <stsp@aknet.ru>) id 1IbX7V-0008Pn-A8
	for alsa-devel@alsa-project.org; Sat, 29 Sep 2007 11:52:13 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

Trying to get a software amplification to
work with NForce CK804 AC'97, I've found
out that whatever the asound.conf I write,
the sound starts playing much faster than
it should.
After some debugging, I've found out the
following:
- The card (or the driver) only supports
48000KHz.
- The program (any, because libao and artsd
suffer from that) is trying to set some
rate with snd_pcm_hw_params_set_rate_near(),
and that succeeds, but the returned rate
is 48000, while the requested is, say, 22050.
No wonder it then plays with the wrong speed.
Of course the program can check the returned
rate, but it sets the "direction" parameter
to 0, which should mean "take exactly that
value".
I've looked into an alsa-tutorial, and the
examples there do not check the returned
rate too - dir==0 should be enough.

Looking into the sources, it seems the culprit
is the snd_interval_refine_min/max(), which do
not care about the (i->min > min && !openmin)
case at all.

The question is: is setting dir=0 (or even
NULL, since it is a pointer) enough to set
the exact rate?
And if so - how snd_interval_refine_min()
should handle the (i->min > min && !openmin)
case?
Or if not - what does the dir==0 mean
and why it is not adjusted to the proper
value on return, when the rate is changed?
(i.e. the rate parameter changes from
22050 to 48000, but the dir parameter remains
0, doesn't change)

With the default configuration the rate is
proper, but I find it annoying that altering
asound.conf in pretty much any way gets the
wrong results.
