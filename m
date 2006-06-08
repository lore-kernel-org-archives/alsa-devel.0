From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [linuxsh-dev] [PATCH] Add
	support	for	Yamaha	AICA	sound on	SEGA Dreamcast
Date: Thu, 08 Jun 2006 19:16:58 +0100
Message-ID: <1149790618.6041.2.camel@localhost.localdomain>
References: <1149201071.9032.13.camel@localhost.localdomain>
	<1149334788.9065.5.camel@localhost.localdomain>
	<s5hslmimvh5.wl%tiwai@suse.de>
	<1149635448.5154.7.camel@localhost.localdomain>
	<s5h8xo970q7.wl%tiwai@suse.de>
	<1149704202.5087.6.camel@localhost.localdomain>
	<s5hlks82av5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk
	[81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 1D322176
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 20:17:20 +0200 (MEST)
In-Reply-To: <s5hlks82av5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-06-08 at 12:35 +0200, Takashi Iwai wrote:

> 
> It's uncoventional that a work struct is re-initialized on the fly.
> 
> IMO, it's better to introduce a flag indicating the stream is already
> running and use a single function/work struct.  For example,

Yes, I've did this sort of thing last night :)
