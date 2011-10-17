From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: /dev/dsp open failure
Date: Mon, 17 Oct 2011 13:25:15 +0200
Message-ID: <4E9C109B.5000502@ladisch.de>
References: <CAODvfaFr-GiT1N=t3m9ZexdFQT00un5S2dX+uqMn-cN9=D4mGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C4C6C103893
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 13:24:51 +0200 (CEST)
In-Reply-To: <CAODvfaFr-GiT1N=t3m9ZexdFQT00un5S2dX+uqMn-cN9=D4mGA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Appalayagari Sreedhar <sreecha01@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Appalayagari Sreedhar wrote:
> when i try to open the device using /dev/dsp i am getting the -ve value.

The what?

> after doing aplay i am able to open the device using the /dev/dsp.

So probably the sound driver module or the snd-pcm-oss module is not
loaded?


Regards,
Clemens
