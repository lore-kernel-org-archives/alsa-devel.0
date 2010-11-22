From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] cm6206: turn off de-emphasis in s/pdif
Date: Mon, 22 Nov 2010 16:42:38 +0100
Message-ID: <4CEA8F6E.6040703@ladisch.de>
References: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>	<4CE4EDAF.4010200@ladisch.de>
	<s5hoc9httbe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E71F8244C9
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 16:40:21 +0100 (CET)
In-Reply-To: <s5hoc9httbe.wl%tiwai@suse.de>
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
Cc: Eric Lammerts <alsa-devel@lists.lammerts.org>, alsa-devel@alsa-project.org, Dan Allongo <gongo2k1@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Eric Lammerts wrote:
> > > I noticed on my DAC that the de-emphasis LED was on. Is this by
> > > accident?
> > 
> > Probably.  The mechanism to set the S/PDIF status bits should be added
> > to the driver, but as long as we do not have that, setting this bit by
> > default is silly.
> 
> Clemens, would you implement this?

Yes, it's on my TODO list.


Regards,
Clemens
