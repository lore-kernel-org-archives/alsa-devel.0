From: Jay Fenlason <fenlason@redhat.com>
Subject: Re: [FFADO-devel] [RFC v3] [PATCH 00/52] Enhancement for support of
	firewire devices
Date: Fri, 21 Feb 2014 11:54:44 -0500
Message-ID: <20140221165444.GA25817@redhat.com>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I finally got a chance to try this patch set on one of my machines
with a Griffin FireWave and a Presonus Inspire1394.

I was able to play audio to the Inspire1394, however when I started to
attempt recording from it, the machine crashed.  I have not yet
debugged the crash.  Also, the driver did not find any of the mixer or
volume control elements on the device, which was slightly frustrating
because it has no physical controls and ffado also doesn't know about
the mixer controls.  I'll have to try the userspace mixer application
I wrote, but I haven't had a chance yet.

I could not play audio through the FireWave (either directly via aplay
or through PulseAudio).  This is a regression from the fwspkr driver,
which worked on this machine.  I have not yet bisected the regression,
but alsa refers to the device as "Surrou", which suggests that
something is overflowing a buffer or truncating the name somewhere.

sysdefault:CARD=Surrou
    Griffin FireWave Surrou, Griffin FireWave Surrou
    Default Audio Device

With luck I will be able to do some more debugging this weekend.
I also need to hook up my iSight and make sure its audio still works.

		-- JF

P.S.  On Fedora (at least) the udev configuration has bitrotted
somewhere in the past two years so that the audio devices show up
as the firewire card and not themselves.  The udev maintainers had
fixed that a couple of years ago, but somewhere between then and now
it seems to have stopped working.

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
