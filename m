From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 21:10:27 +0200
Message-ID: <7c5010d60909031210o4a1be3f9v7531f03ed1926e9c@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909030803h1c354c79ob774683d764ea062@mail.gmail.com>
	<s5h4orkqd22.wl%tiwai@suse.de>
	<7c5010d60909030812k5f865622i5cddcd978788c338@mail.gmail.com>
	<7c5010d60909030826k122fa855t153458431cd18909@mail.gmail.com>
	<s5h1vmoqc71.wl%tiwai@suse.de>
	<7c5010d60909030835n2d62756cr1e29de479b7a9d97@mail.gmail.com>
	<s5hws4gox1l.wl%tiwai@suse.de>
	<7c5010d60909031003l317d7325s9082a30c418a28f8@mail.gmail.com>
	<s5hzl9bc3mo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BD4110384A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 21:10:28 +0200 (CEST)
Received: by bwz25 with SMTP id 25so185840bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 12:10:27 -0700 (PDT)
In-Reply-To: <s5hzl9bc3mo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 7:57 PM, Takashi Iwai<tiwai@suse.de> wrote:
>
> But, *what* is actually the problem? =A0In your post, there was no clear
> description of the bug -- how is the behavior at all?

Problem is:

the channel driver uses Skype client, and uses an API call to make it
do audio I/O to tcp sockets (to listening sockets of the channel
driver itself).

*BUT* the Skype client insists to have a soundcard, probably for
getting its timing from.

Actually interfacing with an actual soundcard is taxing badly the cpu
(for dmix/dsnoop/plug overhead), takes irqs, and do not scale (you
cannot have 30 Skype clients happily sharing the same soundcard).

So for "heavy duty" it uses the snd-dummy.

It works perfectly, and scales very well, with the Ubuntu 8.04 kernel,
eg: a tickless 100HZ kernel.
It works perfectly on Centos is uses the other snd drivers.
It works perfectly on Centos with a compiled kernel like the Ubuntu 8.04 on=
e.
It works very bad (with glitches, accumulating delays, hiccups, etc)
on Centos with the original Centos kernel (1000HZ, not tickless).

The ALSA unstable snapshot, and the first patch to it you sent me do
not solves the problem.

Now I will try the last patches you sent me today and report here.

Thanks a lot for your efforts,

-giovanni
