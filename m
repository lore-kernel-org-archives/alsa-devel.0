From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Wed, 24 Feb 2010 10:16:34 +0100
Message-ID: <4B84EE72.4060707@ladisch.de>
References: <20091006063609.B06E110381F@alsa0.perex.cz>	<s5hab05role.wl%tiwai@suse.de>	<4ACAF4AC.3000608@ladisch.de>	<s5h4oqdrlys.wl%tiwai@suse.de>	<4ACDCAAB.2060609@ladisch.de>	<s5h1vlexesm.wl%tiwai@suse.de>
	<4ACDDD22.1050309@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 60C4E1038D5
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 10:16:37 +0100 (CET)
In-Reply-To: <4ACDDD22.1050309@ladisch.de>
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

I wrote:
> > > jmal8295 wrote:
> > > > And I _will_ be regarding it as regression if I lose possibility to
> > > > change volume of the four streams independently.
> 
> Okay, I'll see if I can extend alsamixer ...

Well, those controls are quite hardware-specific, and I always wanted to
try out the Python wrappers, so I wrote a separate application.

Honza, if you have a new kernel and the latest released alsa-lib and
alsa-python packages, please try downloading the latest alsa-tools
snapshot from <http://www.alsa-project.org/snapshot/> and check the
hwmixvolume tool.


Regards,
Clemens
