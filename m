From: Adam Williamson <awilliam@redhat.com>
Subject: Re: CONFIG_SND_HDA_INTEL regression on 2.6.37-rc3 - no
 audio
Date: Fri, 17 Dec 2010 01:04:24 +0000
Message-ID: <1292547864.2025.53.camel@vaioz>
References: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
	<s5h8w0ang0e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 09ECB1037F5
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 02:04:33 +0100 (CET)
In-Reply-To: <s5h8w0ang0e.wl%tiwai@suse.de>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, "Luis R. Rodriguez" <mcgrof@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-01 at 07:50 +0100, Takashi Iwai wrote:
> At Tue, 30 Nov 2010 13:31:46 -0800,
> Luis R. Rodriguez wrote:
> > 
> > I just booted 2.6.37-rc3 and noticed my sound with
> > CONFIG_SND_HDA_INTEL stopped working, I get no audio at all. Is this a
> > known regression? I can bisect if not.
> 
> I haven't heard of such a regression, so far.  Which kernel did work?
> 2.6.37-rc2 worked?  After rc2, there aren't so many commits for
> HD-audio, so if it's a regression, it's likely in another deeper
> part, I guess.

I reported a 2.6.36 to 2.6.37 regression in HDA_INTEL for my Vaio Z to
the bugtracker:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5216

it's perfectly reproducible - I have a 2.6.36 and a 2.6.37 kernel both
installed on here, I have to boot the 2.6.36 one for sound to work and
the 2.6.37 one for bluetooth to work. =)
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Fedora Talk: adamwill AT fedoraproject DOT org
http://www.happyassassin.net
