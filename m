From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Why analog loopback of sigmatel devices got
 removed?
Date: Fri, 19 Jun 2009 11:21:41 +0300
Message-ID: <1245399701.8549.2.camel@localhost>
References: <1245369035.6830.27.camel@localhost> <s5h1vpgg2d6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B9A10389D
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 10:21:46 +0200 (CEST)
Received: by fxm26 with SMTP id 26so947911fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 01:21:45 -0700 (PDT)
In-Reply-To: <s5h1vpgg2d6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-06-19 at 08:32 +0200, Takashi Iwai wrote:
> At Fri, 19 Jun 2009 02:50:35 +0300,
> Maxim Levitsky wrote:
> > 
> > Hi,
> > 
> > Due to lack of time, I didn't update kernel on my desktop system.
> > Now I notice that analog loopback go removed. Why?
> 
> Because it harms than helps more often.  I've got tons of bug reports
> and been upset just because users blindly set "Analog Loopback" mixer
> switch and lost their sound output.  This is no mixer element that
> behaves intuitively -- it shuts out PCM output instead of adding the
> analog loopback like other hardwares.

Here it doesn't shut PCM.
I just hear input in headphones, mixed with output.
I suspect that this feature might not work correctly on newer devices
that ones I have added.

> 
> The feature is still available, though.  You just need to give the
> driver an instruction via sysfs.  Namely, write to sysfs files
> corresponding to the IDT codec like
> 	# echo "loopback yes" > /sys/class/sound/hwC0D0/hints
> 	# echo 1 > /sys/class/sound/hwC0D0/reconfig
> Then the driver will reconfigure with the loopback mixer element.
> 	
> I have a patch series to add this with a "patch" firmware file to
> make it easier, which I'm going to send an RFC to this ML soon later.
> Take a look at topic/hda-patch branch on sound-unstable tree.
> 
> 
> thanks,
> 
> Takashi
