From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
Date: Sat, 11 Feb 2006 17:07:32 -0500
Message-ID: <1139695653.19342.130.camel@mindpipe>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
	 <7c3341450602110556u75c4bfffq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750728AbWBKWHh@vger.kernel.org>
In-Reply-To: <7c3341450602110556u75c4bfffq@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick <nick@linicks.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-02-11 at 13:56 +0000, Nick wrote:
> Now the question - there have been a lot of alsa changes (since my
> alsa-tools was built Slack 10) - do we need to keep the alsa tools and
> stuff current too? 

Yes - kernel upgrades should depend on alsa-lib upgrades (many distros
seem to get this wrong).  This should be fixed in the future, but it's
been this way for some time.

Lee
