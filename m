From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] [snd-usb-audio] Add match for JMTek USB sound	card
Date: Sun, 18 Oct 2009 18:37:28 +0200
Message-ID: <1255883848.2313.4.camel@localhost.localdomain>
References: <1255173329-20485-1-git-send-email-lkundrak@v3.sk>
	 <4AD2D0C2.40307@ladisch.de> <s5hzl7xdqrn.wl%tiwai@suse.de>
	 <1255334633.3286.4376.camel@localhost.localdomain>
	 <s5hocoddofb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <s5hocoddofb.wl%tiwai@suse.de>
Sender: linux-sound-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-10-12 at 10:08 +0200, Takashi Iwai wrote:
> At Mon, 12 Oct 2009 10:03:53 +0200,
> Lubomir Rintel wrote:
> > 
> > On Mon, 2009-10-12 at 09:18 +0200, Takashi Iwai wrote:
> > > At Mon, 12 Oct 2009 08:46:26 +0200,
> > > Clemens Ladisch wrote:
> > > > 
> > > > Lubomir Rintel wrote:
> > > > > Entry for JMTek LLC., SSS USB Headphone Set in the quirk table.
> > > > 
> > > > Please add an explaination why this entry is needed.  At first glance,
> > > > this entry seems to describe a class-compliant device that should not
> > > > need a quirk.
> > > 
> > > Ah right.  It'd really helpful if Lubomir can give more details...
> > 
> > A 2.6.31.1-based kernel on my Fedora 12 workstation at hone seemed to
> > require that, only the input driver attached to the device when plugged
> > in, the snd-usb-audio didn't seem to load and did not care about the
> > device when loaded manually. I did not have an idea why, since "alias:
> > usb:v*p*d*dc*dsc*dp*ic01isc01ip*" really seemed to match my device.
> > Nevertheless, after finding out that adding an entry to the quirk table
> > solves my problem I concluded that my understanding (or lack of thereof)
> > was wrong and that alias is really not meant to match my device.
> > 
> > Now I plugged the adapter into my work lappy with 2.6.30.8-based Fedora
> > 11 and the audio interfaces on my adapter got instantly recognized and
> > claimed by snd-usb-audio (and the input interface by the input
> > subsystem), without modifying anything.
> > 
> > Any clues what could have gone wrong then?
> 
> Hm, I don't see any affecting changes between 2.6.30 and 31.
> Just as a test, could you copy sound/usb/*.[ch] from 2.6.30 tree to
> 2.6.31 or 32-rc and check whether the same problem appears?

I did not try that, but updated to a newer snapshot and it works as it
used to again, so I don't thing there's much point in finding out what
went wrong now. I'm very sorry for the noise.

Regards,
Lubo

-- 
"Excuse all the blood" -- Dead

