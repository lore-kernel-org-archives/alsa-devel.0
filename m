From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Tue, 06 Oct 2009 09:53:06 +0200
Message-ID: <4ACAF762.8020402@ladisch.de>
References: <20091006063609.B06E110381F@alsa0.perex.cz>	<s5hab05role.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910060930120.31529@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 0D82210380E
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 09:53:10 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0910060930120.31529@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 6 Oct 2009, Takashi Iwai wrote:
> > noreply-git@alsa-project.org wrote:
> >> Author:     Clemens Ladisch <clemens@ladisch.de>
> >>     sound: via82xx: move DXS volume controls to PCM interface
> >>     
> >>     Commit b452e08e73c0e3dbb0be82130217be4b7084299e in 2.6.30 broke the
> >>     restoring of these volumes by "amixer restore" that most distributions
> 
> amixer restore == alsactl restore ?

Oops, yes.

> > Well, this control was once removed, and then revived due to complains
> > by users who have used it in mixer.  Moving this to PCM iface does
> > almost the same thing, disabling an easy way to access it.
> 
> amixer utility should handle such controls without problems.

Yes, it should.  I haven't yet found where the hctl functions break it.

> We have similar volume controls in emu10k1 driver, but having 32 PCM
> volume controls in mixer is not much fun.

It might make sense to show such controls only for opened PCM
substreams, together with the process name.


Best regards,
Clemens
