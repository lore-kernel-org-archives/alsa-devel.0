From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 21 Apr 2008 18:09:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804211808040.7882@tm8103.perex-int.cz>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
	<20080414170022.GH22115@tango.0pointer.de>
	<480392F3.9030701@keyaccess.nl>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
	<20080420010116.GA22033@tango.0pointer.de>
	<s5hej8zcohq.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0804211754120.7882@tm8103.perex-int.cz>
	<s5hod83b3at.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 509402442A
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 18:09:26 +0200 (CEST)
In-Reply-To: <s5hod83b3at.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Apr 2008, Takashi Iwai wrote:

> At Mon, 21 Apr 2008 18:01:24 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Mon, 21 Apr 2008, Takashi Iwai wrote:
> > 
> > > Yeah, I'm indeed very fond of automatic volume setup for desktop
> > > users, too.  I don't know whether it's a role of PA.  Rather I feel
> > > we'd need to add a feature to alsactl, such as,
> > > 	% alsactl init
> > > then it'll either initialize or restore the previous setup.
> > > 
> > > So, anyway, what we really need is to gather the data for each
> > > available device to initialize to the "sane" state...
> > 
> > I agree that initialization should be implemented in alsactl, too. I think 
> > that only necessary values (Master, PCM, Front, Wave, enable recording 
> > from Mic) should be kept in database and all other "advanced" controls 
> > should be untouched. Initial values should be hearable minimum.
> 
> BTW, there is another thing to care - the capture.
> In most cases, people don't understand why they can't record from the
> microphone on their laptops out of the box.

Yep, I wrote "enable recording from Mic" :-)

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
