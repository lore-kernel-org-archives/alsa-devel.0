From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: USB Quirks for Boss JS-8
Date: Mon, 21 Mar 2011 12:50:32 +0000
Message-ID: <201103211250.32946.maillist@superlative.org>
References: <201103181756.53155.maillist@superlative.org>
	<AANLkTikU+shHE6Z4cz0Gecy9VO6bg=Cxvpjywrfxfck5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0D75E24399
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 13:51:19 +0100 (CET)
Received: by wyj26 with SMTP id 26so5345538wyj.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 05:51:18 -0700 (PDT)
In-Reply-To: <AANLkTikU+shHE6Z4cz0Gecy9VO6bg=Cxvpjywrfxfck5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 21 Mar 2011 07:54:13 Daniel Mack wrote:
> On Fri, Mar 18, 2011 at 6:56 PM, Keith A. Milner
> > 
> > {
> >        /* Boss JS-8 Jam Station  */
> >        USB_DEVICE(0x0582, 0x0109),
> 
> Does this quirk help anything? I'm just asking because looking at the
> descriptors,it's not clear whether this device does comply to any
> standard interfaces at all. Could be the vendor just hides the
> compliancy, but they might have implemented a proprietary protocol as
> well.

It's supposed to be a 2-in/2-out audio interface. At least that's what it 
shows up with on Windows. The Windows driver README contains the following:

"Of the total audio input/output channels provided by the JS-8, there are 2 
INs and 2 OUTs

[WAVE OUT Devices]
OUT (JS-8)
 
[WAVE IN Devices]
IN (JS-8)
 
[ASIO device]
When using the JS-8 with an ASIO-compatible application such as Cubase, select 
"JS-8" as the ASIO setting for your application.
*	To prevent an audio feedback loop or double monitoring, make settings on 
your application to turn monitoring off or use ASIO Direct Monitoring.
*	The JS-8 does not actually support ASIO Direct Monitoring. For greater 
ease of use, support is simulated.
*	When using the JS-8 with ASIO, we recommend that you set your application 
so that it does not use the Microsoft GS Wavetable SW Synth. (In order to 
decrease the load, and for convenience when changing Audio Buffer Size of the 
driver.)"

It could well be proprietary, but it's a Roland device and my understanding is 
it's not uncommon for Roland to hide standard usb-audio interfaces behind non-
standard identifiers.

I have USB Device Monitoring Studio on my Windows laptop so I can dig further, 
although I'm not entirely sure what I should be looking for.

Cheers,


-- 
Keith A. Milner
