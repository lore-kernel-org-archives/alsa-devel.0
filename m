From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.0-rc3: sound broken in chromium but not in mpg123
Date: Tue, 24 Mar 2015 20:01:59 +0100
Message-ID: <20150324190158.GA29071@amd>
References: <20150314201109.GA21052@amd> <s5htwxmr85c.wl-tiwai@suse.de>
 <20150315081544.GA17650@amd> <s5hr3sqr7nw.wl-tiwai@suse.de>
 <20150316123719.GA14161@amd> <s5hoanthx6z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 29D742604A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 19:57:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hoanthx6z.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi!

> > > OK, then another thing I would check is to try different sample rates
> > > (e.g. via playing WAV files over PA).
> > 
> > Like this?
> > 
> > pavel@amd:/usr/share$ pacat ./sounds/alsa/Front_Right.wav
> > pavel@amd:/usr/share$ pacat --rate=48000 ./sounds/alsa/Front_Right.wav
> > pavel@amd:/usr/share$ pacat --rate=44100 ./sounds/alsa/Front_Right.wav
> > pavel@amd:/usr/share$ pacat --rate=32000 ./sounds/alsa/Front_Right.wav
> > pavel@amd:/usr/share$ pacat --rate=16000 ./sounds/alsa/Front_Right.wav
> > pavel@amd:/usr/share$ pacat --rate=8000 ./sounds/alsa/Front_Right.wav
> > 
> > This seems to have behaved as expected.
> 
> Hmm.  You might see a difference when comparing
> /proc/asound/card*/pcm0p/sub0/* files between working and broken
> cases (while playing something).
> 
> Other than that, I have no idea.  A bisection would be needed, I'm
> afraid.

:-(.

To make it more fun, it now appeared on x60... it looks like it has
something to do with starting browser early after boot.

Restarting the browser seems to fix it.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
