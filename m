From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: how to mandate the use of PCM plugin?
Date: Mon, 27 Sep 2010 08:48:29 +0400
Message-ID: <4CA0221D.6030208@aknet.ru>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id A651D24515
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 06:49:35 +0200 (CEST)
In-Reply-To: <20100927005858.GD21247@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  Hello.

27.09.2010 04:58, Mark Brown wrote:
>> Is it possible to somehow mandate the
>> use of a PCM plugin? For example, the
>> PC-Speaker.conf defines the use of softvol
>> plugin for "default" and "front" devices.
>> It is still possible for the software to bypass
>> it by the use of "hw", and some software
>> does exactly that.
>> Is it possible to somehow make some
>> plugin a mandatory?
> What is the actual problem you are trying to solve here?  It's not
> possible to *mandate* anything to all users, if nothing else someone
> with administrative access can always rebuild whatever part of the
> system is trying to restrict them.
What I am trying to solve, is the problem
that people have with my snd-pcsp driver.
Pulseaudio uses "hw" to bypass some pcm
plugins, and then people are left with the
non-functional softvol control, and they blame
my driver.
I am looking for the way to mandate the
softvol plugin even for the "hw" device.
Is this possible?
