From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Tue, 8 Sep 2009 17:34:35 +0200
Message-ID: <7c5010d60909080834h2e1f082v3d7124f9ebf7f102@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
	<7c5010d60909070400n48b5d494h1769285c958e9626@mail.gmail.com>
	<s5heiqjxbc8.wl%tiwai@suse.de>
	<7c5010d60909071205o74873cadh5eb3703224531940@mail.gmail.com>
	<s5hocpl60ax.wl%tiwai@suse.de>
	<7c5010d60909080629s502f99c7l43f1dccf84aa4d8@mail.gmail.com>
	<s5hiqft5zjv.wl%tiwai@suse.de>
	<7c5010d60909080805o7f707a0cx10d7699803ef0ef2@mail.gmail.com>
	<s5h8wgp5v6n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 54129245A0
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 17:34:37 +0200 (CEST)
Received: by bwz25 with SMTP id 25so2760969bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2009 08:34:36 -0700 (PDT)
In-Reply-To: <s5h8wgp5v6n.wl%tiwai@suse.de>
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

On Tue, Sep 8, 2009 at 5:10 PM, Takashi Iwai<tiwai@suse.de> wrote:
> Don't pass '=3D', e.g.
>
> =A0 =A0 =A0 =A0# echo channels_max 3 > /proc/..../dummy_pcm
>

Thanks, with your hint I was able to write to the proc file.

I confirm that the Skype client works well if I put (writing to the
proc file, without modifying the driver source): buffer_bytes_max=3D1024
and period_bytes_max=3D512, and that it works bad if I do not write on
the /proc file.

It would be very very very nice if you add this proc interface (or
another method to alter those buffer and period values) also to the
non-debug build, so users can be able to use the standard distributed
prepackaged ALSA drivers, without resorting to editing source or
recompiling.

BTW: Would you mind to bump the MAX_PCM_SUBSTREAMS to 128? Currently
is 16, and is a cap to the substreams actually created, by a
configurable param default to 8. (people use routinely 20 concurrent
Skype clients, 40 substreams. But there is juice in modern servers to
have some more. 64 seems roomy enough [Skype client itself uses lot of
cpu]).

Thanks for all your efforts,

-giovanni
