From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Stupid question #1 of many -- unit test harness?
Date: Mon, 15 Apr 2013 16:38:16 +0200
Message-ID: <516C10D8.2050201@ladisch.de>
References: <loom.20130415T023733-422@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5A6F926517E
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 16:38:31 +0200 (CEST)
In-Reply-To: <loom.20130415T023733-422@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: TJ Olaes <contact@olaes.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TJ Olaes wrote:
> So, I'm attempting to write the driver for the eClaro card for a couple of
> reasons, one of which is that I currently don't have sound on mine.
>
> So... is there some kind of test harness framework for new drivers?

No.  You test drivers by trying to use them.

> I have no prior idea how to move forward to build this thing, so I'm snoo=
ping
> around in the oxygen source files and trying to copy things that look like
> they make sense.

All the basic boilerplate code already is in oxygen_lib.c.  What's left
for you are the _interesting_ parts where you have to know what you're
doing.

> For instance, I noted that there's mention of an "AK4396" related to
> output.  I assume this is some kind of chip

Yes, this is some kind of chip.  As the DAC for the front outputs (as
mentioned on HT Omega's website), a quite important one.

> and I saw in the Claro code that something called "ak4396_init(...)"
> is called, so I just copied that line and pasted it into the
> eclaro_init(...) function I'm writing.

The other Claro cards have four AK4396 chips.  The eClaro has only one
and handles the other six channels with a CS4362 chip.  This is more
similar to the Xonar DX (so you might want to get inspiration from
xonar_cs43xx.c), but the eClaro obviously uses SPI instead of I=B2C
because that's the only protocol that the AK4396 supports.

> I have no idea how I'm going to test this short of just compiling the ker=
nel
> and booting into it.

You should compile the sound driver as a module, then you'll have to
reboot only when it crashes.  ;-)


It might be more productive for me to write the driver, if you are able
to compile your own kernel and to test it.


Regards,
Clemens
