From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 08:45:43 +0200
Message-ID: <4DD4BC97.5090702@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
	<s5hhb8r1c20.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id A9918103871
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 08:45:47 +0200 (CEST)
In-Reply-To: <s5hhb8r1c20.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am 19.05.2011 07:42, schrieb Takashi Iwai:
> I see no big reason to make things more complex.  If you want to avoid
> the standard audio parsing after quirk but only parse mixer, just call
> snd_usb_create_mixer() in your quirk function.
>

Maybe I'm misunderstanding your point. But I think your suggestion is 
making things more complex.

I don't want to avoid the standard audio parsing. I want to use standard 
quirks if possible and still would like a means to call 
snd_usb_create_mixer(). That's all.

The device in question can be handled by a standard quirks 
(QUIRK_ANY_INTERFACE, QUIRK_COMPOSITE, QUIRK_AUDIO_FIXED_ENDPOINT). 
There's no hook for calling snd_usb_create_mixer() by the respective 
quirk functions, is there? Should I really need not to use those 
standard quirks just to call snd_usb_create_mixer()?

Moreover, I can't believe that the Fast Track Ultra devices are the only 
ones in the world which have a standard USB mixer without exposing it 
through the descriptors. (I've often read something like "but the mixer 
won't work") A simple generic standard way to handle those devices would 
be nice to have.

Take a look at it from my perspective: I'm just a layman on all of this. 
I full heartedly confess, that I don't actually understand all those 
functions involved in making a mixer work. I don't understand usb 
control messages an so on.
For example, take a look at the snd_nativeinstruments_control_put() 
function as Daniel suggested. There's a line

     usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
                   USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
                   cpu_to_le16(wValue), cpu_to_le16(wIndex),
                   NULL, 0, 1000);

What is it? How is anyone not deeply involved with USB programming 
and/or audio device programming supposed to understand it? How is 
anybody supposed to help Alsa development to get his device working 
without deeply diving into all this stuff *which should not be needed*?

But being a layman I could still understand that the mixer unit in my 
device is there and that it is controlled by standard usb commands 
(control messages?). So what to do next?

For the capture, playback and MIDI side it's already simple: If you have 
a device that you suspect to be more or less standard compliant but just 
doesn't tell the world about it he can just try some combinations of  
QUIRK_AUDIO_FIXED_ENDPOINT, QUIRK_AUDIO_STANDARD_INTERFACE, 
QUIRK_MIDI_FIXED_ENDPOINT etc. (which by the way are still not easy to 
understand due to lack of documentation!).

For mixers, there isn't such a standard way. That's what I would like to 
have! And that's what I have at least sketched with my patch. (While the 
standard way to tell the driver to call snd_usb_create_mixer() is still 
missing.)

Take a look at my (maybe naive?) snd_ftu_controls_create() function. 
It's easy to understand, it's simple:
I essentially just pass channel numbers, and names to 
build_named_mixer_unit_ctl() which is a slightly modified version of 
build_mixer_unit_ctl() and voila: I get a volume control for the 
respective mixer channel, just as if the control had been known from a 
descriptor. That's a lot easier to understand than fiddling around with 
usb_control_msg(), isn't it?

So, at the end as stated above, I would like to see a simple, easy to 
understand standard way to handle a mixer that essentially *is* a 
standard USB audio mixer but doesn't tell the world about it...And of 
course, it should work with my device ;-)

Kind regards,

Felix
