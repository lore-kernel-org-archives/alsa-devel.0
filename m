From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA - Add support for the OQO Model 2
Date: Fri, 01 Feb 2008 07:01:44 -0800
Message-ID: <1201878104.24072.22.camel@razman.gruemaster.com>
References: <1201822394.23369.108.camel@razman.gruemaster.com>
	<s5hejbw3mc8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8495E24588
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 16:01:46 +0100 (CET)
In-Reply-To: <s5hejbw3mc8.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 2008-02-01 at 13:14 +0100, Takashi Iwai wrote:

> At Thu, 31 Jan 2008 15:33:14 -0800,
> Tobin Davis wrote:
> > 
> > This patch adds support for the OQO Model 2 Ultra Mobile PC.
> > 
> > 
> > Signed off by Tobin Davis <tdavis@dsl-only.net>
> 
> Thanks.  I'll apply it after 1.0.16 release.


When's the next release window?  My contact at IDT (Sigmatel) was hoping
to get it in this release, he just didn't get back to me with the test
results until yesterday.

Also, I had some very strange audio garbage with the tip on an HD Audio
platform that normally works ok.  I'm going to be tracking it down this
morning, once I get to work (1 hour).  I'm not sure if it is related to
the AD1986a or the SCH (gcap patch).  I do know that GCAP returns 2200
on this system, whereas a normal ICH returns 4401.  The last bit may be
significant (64bit vs 32bit stream).  I need to reverify the SCH value,
but this may be causing the issue.  This is critical for a launch coming
up.

-- 
Tobin Davis 


Photographing a volcano is just about the most miserable thing you can do.
		-- Robert B. Goodman
	[Who has clearly never tried to use a PDP-10.  Ed.]
