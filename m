From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 16:23:56 +0200
Message-ID: <7c5010d60909030723l44055b5au84a487d78ef6252f@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de> <s5heiqoqfh4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CE7124570
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 16:23:57 +0200 (CEST)
Received: by fxm3 with SMTP id 3so1665789fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 07:23:56 -0700 (PDT)
In-Reply-To: <s5heiqoqfh4.wl%tiwai@suse.de>
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

On Thu, Sep 3, 2009 at 4:18 PM, Takashi Iwai<tiwai@suse.de> wrote:
> I worked on it ago, and changed the code to update in a better way.
> But forgot to apply to the upstream.
>
> Now I digged down, and resurrected it with the highres timer support
> as a quick hack.
>
> The patches are found in sound-unstable GIT tree topic/dummy-hrtimer
> branch:
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6=
.git topic/dummy-hrtimer
>
> and in alsa-driver-unstable snapshot as well:
> =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-drive=
r-unstable-snapshot.tar.gz
>
>
> Giovanni, give it a try. =A0If it works, I'm going to add it to 2.6.32.

Thanks Takashi, I'll try the snapshot immediately and report here!

-giovanni
