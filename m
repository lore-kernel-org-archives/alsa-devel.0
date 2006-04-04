From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: Patch for AICA sound support on SEGA Dreamcast
Date: Mon, 03 Apr 2006 20:36:25 -0400
Message-ID: <1144110986.22082.4.camel@mindpipe>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <443162B4.60500@kenati.com> <s5hzmj28q8k.wl%tiwai@suse.de>
	 <200604040116.13732.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964919AbWDDAgd@vger.kernel.org>
In-Reply-To: <200604040116.13732.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Carlos Munoz <carlos@kenati.com>, Adrian McMenamin <adrian@mcmen.demon.co.uk>, Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-04 at 01:16 +0100, Alistair John Strachan wrote:
> I think this write-up provides justification. However, it is not part
> of linux/Documentation/CodingStyle. Perhaps somebody should add these
> details to this file, so that new code follows this currently
> 'unwritten' rule. 

Well, if you look at the current ALSA code, the only typedefs provided
are for backwards compatibility.  They were all removed from the drivers
months ago.  The problem is that you were working against old code.  The
main coding style rule is to follow the conventions of the nearby code,
which would mean no typedefs in the ALSA driver case.

Lee
