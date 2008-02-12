From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Tue, 12 Feb 2008 23:57:46 +0100
Message-ID: <200802122357.46309.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<s5hmyq6t7u5.wl%tiwai@suse.de>
	<200802121924.35232.strohel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 48EF7103905
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 23:57:51 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1408181nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 14:57:50 -0800 (PST)
In-Reply-To: <200802121924.35232.strohel@gmail.com>
Content-Disposition: inline
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 12 of February 2008 19:24:35 Matej Laitl wrote:
> > > Yes, this "slightly better" patch applied on top of your first patch
> > > against hda_codec.c did the trick, but with some side-effects:
> > > (...)

Now I just found that the new "Speaker" switch forgets it's value from time to 
time, ie. it's muted, you go and have lunch, and when you get back and start 
the music, it's unmuted. It is probably related to aggressive hda-codec 
powersaving, which I have enabled and set to 20 secs.

Matej
