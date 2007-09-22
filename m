From: Shane Hathaway <shane.list.alsa-devel@hathawaymix.org>
Subject: Re: Phoenix Audio Duet
Date: Sat, 22 Sep 2007 03:22:37 -0600
Message-ID: <46F4DEDD.9070806@hathawaymix.org>
References: <46F2047A.2090605@hathawaymix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.afconnect.com (mail.afconnect.com [216.83.140.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 834001037EF
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Sep 2007 11:22:56 +0200 (CEST)
Received: from [192.168.1.10] (tiger.hathawaymix.org [192.168.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pigeon.hathawaymix.org (Postfix) with ESMTP id 09A8D7A4A87
	for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2007 03:22:42 -0600 (MDT)
In-Reply-To: <46F2047A.2090605@hathawaymix.org>
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

Shane Hathaway wrote:
> I just bought a set of Phoenix Audio Duets for VOIP conferencing.  They
> are USB speakerphones with good echo cancellation.  They work fine with
> the snd_usb_audio module, with one exception: I can't control the
> microphone and speaker levels.  ALSA exposes some controls, but they
> have no effect, so I have to shout to be heard.

Update: it turns out that the Duet mixer controls work perfectly with
alsamixer and amixer.  So once I have the card index (3 in my case), all
I have to do is this:

amixer -c 3 sset 'PCM',0 100%

Once I did that, the microphone level was very good.

However, mysteriously, the microphone level control in kmix is not
working (it does not generate any USB events at all) and neither of the
level controls in Ekiga is working.  My system is Gentoo, I'm running
Linux 2.6.22, and my alsa-lib is version 1.0.15_rc2.  I've seen similar
behavior on two Ubuntu Dapper boxes.  I intend to look into these problems.

So I just thought I'd let everyone know that ALSA is fully compatible
with the Duet after all.  Both kmix and Ekiga seem to have trouble with
the level controls, but at least you can fall back to amixer or alsamixer.

Shane
