From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: USB Quirks for Boss JS-8
Date: Mon, 15 Apr 2013 00:00:29 +0100
Message-ID: <10860030.mWvl7vqFHg@kamdesktop>
References: <201103181756.53155.maillist@superlative.org>
 <loom.20121014T211933-673@post.gmane.org> <507D1110.1000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id D5CD9264F2C
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 01:00:31 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id j13so1627070wgh.26
 for <alsa-devel@alsa-project.org>; Sun, 14 Apr 2013 16:00:31 -0700 (PDT)
In-Reply-To: <507D1110.1000609@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 16 Oct 2012 09:47:28 Daniel Mack wrote:
> On 14.10.2012 21:43, Adolfo wrote:
> > I am not able to hear any sounds in my JS-8 connected to my Fedora 17,
> > 
> > The device is recognised by the system, but no sound can be played,
> > I've tried with jack too, but no luck,
> > Can you please tell me if jackd needs any special parameters in order to
> > run with JS-8?
> 
> You might have hit a bug here that I introduced during a refactoring of
> the driver. Unfortunately, I can't reproduce that with any of the
> multiple USB audio devices I have at hand, but someone from the
> alsa-user ML offered me to send over his device that also show this
> problem, so I can have a look. Stay tuned please, and my apologies for
> the trouble.
> 
> Meanwhile, you could check whether any of the kernels between 2.6.39 ->
> 3.4 works for you - they all have the quirk for the JS-8.

If it's any help, I'm running Linux Mint 13 with a 3.2.0-34 kernel and it's 
working for me. I do get the following in dmesg:

[47696.764621] usb 1-6.2: new high-speed USB device number 12 using ehci_hcd
[47696.858892] MIDIStreaming interface descriptor not found
[47696.859099] init_device failed: MIDI 4-0: seq-midi

This is due to an error in the original quirk I submitted which was brought to 
light when some changes were made to the USB driver. I will try to tidy it up 
sometime.

Cheers,

Keith
