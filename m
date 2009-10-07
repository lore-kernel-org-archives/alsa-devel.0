From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Wed, 07 Oct 2009 09:59:13 +0200
Message-ID: <4ACC4A51.1010606@ladisch.de>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de> <4ACAF4AC.3000608@ladisch.de>
	<Pine.LNX.4.64.0910061955510.18975@artax.karlin.mff.cuni.cz>
	<4ACC35B2.5030508@ladisch.de>
	<Pine.LNX.4.64.0910070840250.20794@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 930E01037F8
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 09:59:20 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0910070840250.20794@artax.karlin.mff.cuni.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jmal8295 <jmal8295@artax.karlin.mff.cuni.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

jmal8295 wrote:
> > With the new controls, the only way to change them would be on the
> > command line:
> >   amixer cset iface=PCM,name="PCM Playback Volume",subdevice=x yy
> 
> Hmmm ... that is almost as cumbersome as it could be. Is it at least
> planed to add it to some other mixer, like alsamixer? Another view
> perhaps?

That would be useful (also for the same controls of the Emu10k1 and
DS-1 drivers).

> > BTW: How do you determine which of the four controls is associated with
> > a specific application?
> 
> Trial and error :-).

A mixer application/view that knows about these controls could show the
program name, but that would require that ALSA gives out information
about the process that has opened a substream.

> > In any case, the main purpose of the patch was to rename the controls to
> > prevent "alsactl restore" from restoring the old wrong volume setting,
> > so it would suffice to just change the controls' name in some way, such
> > as from "VIA DXS" to "DXS".
> 
> I would propose to use this oportunity to rename them to something more
> descriptive, but I have no idea what that could be (considering limited
> space in mixer programs).

"PCM Stream"?


Best regards,
Clemens
