From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Thu, 08 Oct 2009 14:37:54 +0200
Message-ID: <4ACDDD22.1050309@ladisch.de>
References: <20091006063609.B06E110381F@alsa0.perex.cz>	<s5hab05role.wl%tiwai@suse.de>	<4ACAF4AC.3000608@ladisch.de>	<s5h4oqdrlys.wl%tiwai@suse.de>	<4ACDCAAB.2060609@ladisch.de>
	<s5h1vlexesm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 865AF1039BF
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 14:38:00 +0200 (CEST)
In-Reply-To: <s5h1vlexesm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Honza Maly <jmal8295@artax.karlin.mff.cuni.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > jmal8295 wrote:
> > > And I _will_ be regarding it as regression if I lose possibility to
> > > change volume of the four streams independently.
> > 
> > Okay, as long as there is no application to handle PCM-interface
> > controls, the DXS controls should not be hidden this way.
> > 
> > Anyway, the volume level regression can be solved by any renaming, so
> > let's do just that.  Takashi, please pick the patch below instead.
> 
> Too late.  I already picked up the older patch.

Okay, I'll see if I can extend alsamixer ...


Clemens
