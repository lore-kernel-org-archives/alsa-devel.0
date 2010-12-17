From: Adam Williamson <awilliam@redhat.com>
Subject: Re: CONFIG_SND_HDA_INTEL regression on 2.6.37-rc3 - no
 audio
Date: Fri, 17 Dec 2010 01:09:19 +0000
Message-ID: <1292548159.2025.54.camel@vaioz>
References: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
	<s5h8w0ang0e.wl%tiwai@suse.de>  <1292547864.2025.53.camel@vaioz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 098FE103814
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 02:09:26 +0100 (CET)
In-Reply-To: <1292547864.2025.53.camel@vaioz>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, "Luis
	R. Rodriguez" <mcgrof@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-17 at 01:04 +0000, Adam Williamson wrote:

> > I haven't heard of such a regression, so far.  Which kernel did work?
> > 2.6.37-rc2 worked?  After rc2, there aren't so many commits for
> > HD-audio, so if it's a regression, it's likely in another deeper
> > part, I guess.
> 
> I reported a 2.6.36 to 2.6.37 regression in HDA_INTEL for my Vaio Z to
> the bugtracker:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5216
> 
> it's perfectly reproducible - I have a 2.6.36 and a 2.6.37 kernel both
> installed on here, I have to boot the 2.6.36 one for sound to work and
> the 2.6.37 one for bluetooth to work. =)

Now I notice someone followed up to the report with some questions, but
Mantis didn't notify me! Didn't realize it doesn't do that by default.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Fedora Talk: adamwill AT fedoraproject DOT org
http://www.happyassassin.net
