From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 12:38:46 +0200
Message-ID: <7c5010d60909040338x69700bf5kef90819625679d1e@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
	<7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
	<s5h7hwfb3h2.wl%tiwai@suse.de>
	<7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
	<7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
	<s5h8wgv12y1.wl%tiwai@suse.de>
	<7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
	<s5h3a73109p.wl%tiwai@suse.de> <s5hzl9bypj3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 13C3C24372
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 12:38:48 +0200 (CEST)
Received: by bwz25 with SMTP id 25so572692bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 03:38:46 -0700 (PDT)
In-Reply-To: <s5hzl9bypj3.wl%tiwai@suse.de>
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

On Fri, Sep 4, 2009 at 12:26 PM, Takashi Iwai<tiwai@suse.de> wrote:
>
> BTW, I added another patch to snd-dummy driver in sound-unstable tree.
> Now it doesn't allocate the real buffers but fakes. =A0It would save
> lots of memory when you run lots of substreams.

SUPER! By the way, I was also using the bh for spinlocks, so it do not
uses irq heavily...
But anyway, when we'll be out from this, I will try to see if I can
contribute some of my hacks (if I can overcome the shame ;-) ).

-giovanni
