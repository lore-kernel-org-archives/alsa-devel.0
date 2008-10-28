From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.26.[6|7] vs. rt11 vs. alsa (usb) midi
Date: Tue, 28 Oct 2008 14:35:55 -0700
Message-ID: <1225229755.3750.1.camel@localhost.localdomain>
References: <1224989187.3706.7.camel@localhost.localdomain>
	<s5hljwazc9i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.stanford.edu (smtp3.Stanford.EDU [171.67.20.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 7569624540
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 22:43:08 +0100 (CET)
In-Reply-To: <s5hljwazc9i.wl%tiwai@suse.de>
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
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-10-27 at 09:13 +0100, Takashi Iwai wrote:
> At Sat, 25 Oct 2008 19:46:27 -0700,
> Fernando Lopez-Lezcano wrote:
> > 
> > Hi... anyone out there also having problem with this combination?
> >    2.6.26.7 or 2.6.26.6 with 2.6.26.6-rt11 and alsa MIDI
> > It looks to me like alsa midi is broken. 
> > 
> > Probably an interaction with the realtime kernel patch. A Fedora kernel
> > based on 2.6.26.6 (2.6.26.6-49 on fc8) works fine, a very similarly
> > patched kernel that includes the realtime patch does not. The
> > configurations for both are almost the same (today I tried to change
> > some of the most obvious differences and rebuild, with the same
> > result). 
> > 
> > No problems with 2.6.24.7-rt21. 
> > 
> > Test: boot, login, plugin an external usb keyboard (Yamaha P250), it is
> > recognized, use qjackctl alsa patchbay to connect it to kmidimon,
> > kmidimon sees only _one_ midi message and that's it. Kmidimon can't be
> > killed after that. 
> 
> What about other MIDI devices on other bus, e.g. an MPU401 on a PCI
> soundcard or so?  There is a possibility of breakage in the USB driver
> side, too.

I just tested an RME PCMCIA card + Multiface interface and it shows the
same problem. No MIDI messages get through (but the LED in the Multiface
blinks). Same hardware booted into 2.6.24.7-rt21 works fine. 

-- Fernando
