From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [ath5k-devel] Bugs on aspire one A150
Date: Mon, 01 Dec 2008 17:33:15 +0200
Message-ID: <1228145595.16647.6.camel@maxim-laptop>
References: <491506DB.1070000@gmail.com>
	<b6c5339f0811100851t1fd9a180pfe24312081885467@mail.gmail.com>
	<4918A8C5.3050607@gmail.com>
	<40f31dec0811101412n1a4faf86sf4b1f37bb41caef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FC6A244BA
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 16:33:23 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so964353ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 01 Dec 2008 07:33:22 -0800 (PST)
In-Reply-To: <40f31dec0811101412n1a4faf86sf4b1f37bb41caef9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nick Kossifidis <mickflemm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, ath5k-devel@lists.ath5k.org, Bob Copeland <me@bobcopeland.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-11-11 at 00:12 +0200, Nick Kossifidis wrote:
> 2008/11/10 Maxim Levitsky <maximlevitsky@gmail.com>:
> > Bob Copeland wrote:
> >> On Fri, Nov 7, 2008 at 10:26 PM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> >>> ** 2 - wireless: not to mention the fact that ath5k wasn't installed by
> >>> default in ubuntu...
> >>> wireless more or less works, but kernel log is full of backtraces.
> >>
> >> As you've seen, these should at least be gone now...
> >>
> >>> Was able to connect to my WPA2 access point.
> >>> Sometimes wireless fails completely, especially after suspend to ram.
> >>
> >> Did you get noise calibration failures in dmesg at this point?  Felix posted
> >> a patch recently that handles them better.
> > Yep, but they seems to be gone in latest -git too.
> > Wireless work fine now, it seems like my iwl3945.
> >
> >>
> >>> Advanced features like monitor/injection work, but when I changed the card's
> >>> mac address it stopped working.
> >>> I also noticed that if I then start airodump, then wireless works with new
> >>> mac.
> > Why it doesn't accept new mac?, can this be fixed?
> >
> >
> >>
> >>> ** 4 - wireless led doesn't work.
> >>> ath5k devs, can you fix this?
> >>
> >> Currently all the LED code we have in there is for setting a particular gpio
> >> for particular laptops (and they differ between models).  We only have quirks
> >> for IBM and HP, none for Acer.  Also, the legacy-hal seems to have a different
> >> strategy for 2425 chips.  I can try to hack up some code for you to test.
> >>
> >
> > I have seen on the web that madwifi did support the led with some gpio settings
> >
> > sysctl -w dev.wifi0.ledpin=3
> > sysctl -w dev.wifi0.softled=1
> >
> > from https://help.ubuntu.com/community/AspireOne
> >
> > Best regards,
> >        Maxim Levitsky
> 
> i think that some led settings are stored on EEPROM, let me check it out...
Hi,
Any update on that?

Best regards,
	Maxim Levitsky


> 
> 
