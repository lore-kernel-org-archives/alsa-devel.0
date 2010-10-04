From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Mon, 04 Oct 2010 14:26:56 +0200
Message-ID: <4CA9C810.2030803@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>
	<i8ce5u$fj3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id DBE411038BD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 14:26:11 +0200 (CEST)
In-Reply-To: <i8ce5u$fj3$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> 'Twas brillig, and Clemens Ladisch at 01/10/10 10:02 did gyre and gimble:
> > |   Amp-Out caps: N/A
> > 
> > Is this still "N/A" when you try again?
> 
> Yeah, I've run the script a few times and this has always been N/A.

No problem; according to the datasheet, this node does not have amp-out
caps, and the driver has to read them from the default node instead.
But this appears to work correctly, or you wouldn't have any control for
this node.

> As a more general question, how is the quirk for fixing the 0==mute
> thing added? Is it a kernel patch or some tweak in the /usr/share/alsa/
> tree (i.e. alsalib based quirk?)

At the moment, no working mechanism for changing control information in
user space exists.  (But it should be possible to make the "default"
control device some new plugin that redirects to the "hw" device while
changing some entries.)


Regards,
Clemens
