From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA - Add more support for Dell systems.
Date: Tue, 21 Aug 2007 06:46:17 -0700
Message-ID: <1187703977.4189.255.camel@razman.gruemaster.com>
References: <1187553279.4189.145.camel@razman.gruemaster.com>
	<1187619448.4189.193.camel@razman.gruemaster.com>
	<s5htzqul1hk.wl%tiwai@suse.de> <200708211051.34134.mgerdau@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 97B75243A8
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 15:46:20 +0200 (CEST)
In-Reply-To: <200708211051.34134.mgerdau@tiscali.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Gerdau <mgerdau@tiscali.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The only difference between the Dell-XPS.patch I sent you, and the
Dell.patch I sent to the list was that I added more Dell systems to the
STAC922x portion of the driver (you're using the STAC9200).  Since both
patches were for the same driver, it was just easier this way.  And the
922x portion was tested on #alsa irc.

Tobin

On Tue, 2007-08-21 at 10:51 +0200, Michael Gerdau wrote:

> > > I did.  It worked yesterday according to Michael Gerdau, but apparently it
> > > doesn't today.
> > 
> > Well, that's what I wondered.
> > 
> > Michael, could you check the default pincfg entries in
> > /proc/asound/card0/codec#* whether they really match with the values
> > in patch_sigmatel.c?
> 
> Ok, took me some more time (didn't want to test while almost asleep...)
> 
> /proc/asound/card0/codec#* _do_ reflect the pincfg entries as of
> patch_sigmatel.c
> 
> I also once again have my sound working with both Dell-XPS.patch (the
> one I originally tested) as well as the later version Dell.patch. I
> also have a working LFE control with both patches.
> 
> I have not yet a clear understanding why I did not have sound and LFE
> yesterday. However the thing that's different is that yesterday morning
> I booted into a kernel with the patched alsa and did no other alsa mod
> unload/load until I reverted the patch (when I got back my sound).
> 
> When doing my initial test as well as todays test I booted into the
> pristine hg20070818 (or hg20070817 back then) driver and loaded the
> patched modules via '/etc/init.d/alsasound restart'.
> 
> I can't reboot the machine until about 16:00 today to check whether
> booting into the patched driver does make a difference or not but I
> will do so this afternoon and report my results (of course this could
> be a red hering).
> 
> FYI I've attached /proc/asound/card0/codec#* to this mail in case that
> is of interest.
> 
> Best,
> Michael

-- 
Tobin Davis  


When I works, I works hard.
When I sits, I sits easy.
And when I thinks, I goes to sleep.
