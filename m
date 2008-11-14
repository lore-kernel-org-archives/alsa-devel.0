From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] 2.6.26.[6|7]-rt11, alsa rawmidi, seq hang (tasklet_hi_schedule?)
Date: Fri, 14 Nov 2008 09:15:53 +0100
Message-ID: <491D33B9.5030308@ladisch.de>
References: <1226019485.3135.31.camel@localhost.localdomain>	<49140683.9040008@ladisch.de>	<1226610075.23485.20.camel@localhost.localdomain>	<1226616962.23485.28.camel@localhost.localdomain> <1226621569.23485.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752439AbYKNIPy@vger.kernel.org>
In-Reply-To: <1226621569.23485.44.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@elte.hu>, alsa-devel@alsa-project.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fernando Lopez-Lezcano wrote:
> I've been trying to follow the printk crumbs without much success.
> AFAICT it all points to tasklet_hi_schedule ...

I don't have -rt, but if the error is similar to the old one you might
try replacing tasklet_hi_schedule with tasklet_schedule.


HTH
Clemens
