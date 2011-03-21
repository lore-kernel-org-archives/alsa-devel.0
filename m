From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: USB Quirks for Boss JS-8
Date: Mon, 21 Mar 2011 14:10:14 +0000
Message-ID: <201103211410.14263.maillist@superlative.org>
References: <201103181756.53155.maillist@superlative.org>
	<AANLkTikU+shHE6Z4cz0Gecy9VO6bg=Cxvpjywrfxfck5@mail.gmail.com>
	<4D875382.9000707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B799924419
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 15:10:18 +0100 (CET)
Received: by wyj26 with SMTP id 26so5426726wyj.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 07:10:18 -0700 (PDT)
In-Reply-To: <4D875382.9000707@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 21 Mar 2011 13:32:50 Clemens Ladisch wrote:
> Daniel Mack wrote:
> > On Fri, Mar 18, 2011 at 6:56 PM, Keith A. Milner
> > > I wasn't entirely sure about the quirk syntax as the two interfaces are
> > > at EP 4 and EP5. Does this mean I need to ignore the (non-existant)
> > > lower
> > 
> > > interfaces? Here's what I came up with:
> > Does this quirk help anything?
> 
> Certainly not; endpoint numbers are not interface numbers.  Try with
> audio interfaces 0 and 1 and MIDI interface 2.

Excellent. I will give this a try and see how it goes. I wasn't actually aware 
it had MIDI. I guess this may be used for some sort of control function, or 
maybe it's in the hardware but not supported in the devices firmware.

> 
> > I'm just asking because looking at the descriptors,it's not clear
> > whether this device does comply to any standard interfaces at all.
> 
> Many Roland devices work this way.   (And I'd expect any USB audio
> developer to instantly recognize descriptors like "0b 24 02 01 02 04 18
> 01 44 ac 00". ;-)

I have to profess my ignorance here.

Thanks for you help. I will report back on how I get on.

-- 
Keith A. Milner
