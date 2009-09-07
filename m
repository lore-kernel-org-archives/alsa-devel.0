From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Mon, 7 Sep 2009 21:05:08 +0200
Message-ID: <7c5010d60909071205o74873cadh5eb3703224531940@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
	<s5h3a73109p.wl%tiwai@suse.de> <s5hzl9bypj3.wl%tiwai@suse.de>
	<7c5010d60909040338x69700bf5kef90819625679d1e@mail.gmail.com>
	<s5hpra7ynut.wl%tiwai@suse.de>
	<7c5010d60909040411y76818280p7b7ded46f2df9b64@mail.gmail.com>
	<7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
	<7c5010d60909070400n48b5d494h1769285c958e9626@mail.gmail.com>
	<s5heiqjxbc8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id DA82D244B3
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 21:05:10 +0200 (CEST)
Received: by bwz25 with SMTP id 25so2196035bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 12:05:08 -0700 (PDT)
In-Reply-To: <s5heiqjxbc8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 7, 2009 at 1:07 PM, Takashi Iwai<tiwai@suse.de> wrote:
> BTW, I have merged topic/dummy-hrtimer branch into sound git tree now.
> The standard alsa-driver-snapshot tarball below includes the patches,
> too.
> =A0 =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-d=
river-snapshot.tar.gz
>

Takashi,

I've tested your last tarball all day long :-).

Turned out that the Skype client asks for a too much big buffer (or at
least so it appears to me).

Modifying the MAX_BUFFER_SIZE to 1024 and the MAX_PERIOD_SIZE to 512
it runs smoothly and nice.

Would you mind to add those two as configurable parameters? That would
allows for the direct usage of snd-dummy with the various kernels and
Skype client without any source-code modifications, the ideal solution
:-) .

By the way, the memory consumption and the load are waaaaaay lower!!!!
Very very very nice!

-giovanni
