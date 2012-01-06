From: Greg KH <greg@kroah.com>
Subject: Public ridicule due to sound/soc/soc-core.c abuse of
	the driver model
Date: Fri, 6 Jan 2012 11:40:52 -0800
Message-ID: <20120106194052.GA7781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 5285C2441A
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 20:40:58 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CF6FA20DC0
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 14:40:56 -0500 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Frank, Liam, and sound maintainers.

It was recently pointed out to me that the sound/soc/soc-core.c is
flagrantly abusing the driver model by providing "empty" release
functions, just to keep the kernel from complaining:

/* stop no dev release warning */
static void soc_ac97_device_release(struct device *dev){}

....

static void rtd_release(struct device *dev) {}


As per the documentation in the kernel tree[1], I now get to publicly
mock you for thinking you know better than the driver model.

Come on people, do you think that I wrote the code in the kernel that
produces those errors just for fun?  It was telling you to fix your code
by providing a function to free the structure that is being released,
not to try to trick the kernel because you think you know better.  The
kernel was trying to help you out here, to get the programming model
correct, in a place that was commonly misunderstood.

But, by you trying to be "smart", you just proved that your code was
incorrect and buggy.

Please fix this for the 3.3 kernel release.

Yes, I know it's been there for a number of years, but that still
doesn't make it correct.  Especially as stuff like this tends to get
cut-and-pasted over time.

thanks,

greg k-h

[1] Documentation/kobject.txt
