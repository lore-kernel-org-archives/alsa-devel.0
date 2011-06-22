From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 22 Jun 2011 12:47:35 +0200
Message-ID: <4E01C847.7060505@canonical.com>
References: <4DFF4D15.6050809@canonical.com>	<20110620170739.GD32056@opensource.wolfsonmicro.com>	<4DFF973A.1080404@canonical.com>	<20110620234053.GA1905@opensource.wolfsonmicro.com>	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4565F245E0
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 12:47:38 +0200 (CEST)
In-Reply-To: <20110621123908.GA25980@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 2011-06-21 14:39, Mark Brown wrote:
> On Tue, Jun 21, 2011 at 02:11:15PM +0200, David Henningsson wrote:
>> On 2011-06-21 01:40, Mark Brown wrote:
>
>>> Oh, then in that case we've got another issue in that jacks that happen
>>> not to be associated directly with a sound card for some reason (they're
>>> implemented by the embedded controller and exposed via ACPI for example)
>>> won't be made available to applications.
>
>> Which is not a problem IMO, because in the desktop world this does
>> not happen (or at least I've never seen it), and in the embedded
>> world you have PA running as root anyway.
>
> This seems rather short sighted - the desktop and embedded worlds aren't
> as clearly divided as all that, you've already got things like the
> Genesi systems on the market at the minute running Ubuntu on ARM
> hardware for example and you've also got a bunch of laptop manufacturers
> putting ARM systems in their systems to dual boot into.

If you have a better idea about how to determine if a SW_VIDEOOUT jack 
is actually an audio jack or not, let me know.

>>> OK, well that doesn't seem like an immediately obvious choice.  I can
>>> imagine there might be some concern around keyboards due to passwords
>>> but in general it doesn't seem obvious that the console user shouldn't
>>> be able to read physical input devices on the box (which is the case
>>> we're trying to implement here; we don't need write support).  Do all
>>> classes of input device currently have some root only service to mediate
>>> access to them, and if that is the model we're using perhaps it'd make
>>> sense to have one for this with a dbus interface or whatever that
>>> PulseAudio can talk do rather than to have it talking direct to the
>>> device?
>
>> If I look at what /dev/input devices I have here, that's keyboard,
>> mouse, and ACPI buttons (power, lid close etc). AFAIK, all of those
>> go through the X input layer. Play/pause keys should go through
>> there as well, but are you saying that audio jack events should also
>> go through the X input layer?
>
> I'm asking what the sensible model for handling this stuff is and why we
> need to use a different model for this.  Perhaps this should go through
> the X server, perhaps somewhere else.
>
> It does strike me that the UI may want to be able to join the buttons up
> with the particular jack - for example, if you've got a headset that
> you've got assigned to telephony functions only perhaps the mic short
> button on that headset should only do telephony things.
>
>> If you are, you're welcome to try to fit it in the 248 keycodes that
>> are already occupied, design a new X input extension, or whatever is
>> the right solution for that. I don't know myself.
>
>> If you're not, then that's why this is specific to audio.
>
> It doesn't strike me as an obviously awful solution if that's what we're
> using for things like the ACPI buttons which seem pretty similar - like
> I say one of my questions here is why we need to do something domain
> specific here.  There are certainly a bunch of other switch types in the
> input API which look like the desktop might want to look at them (things
> like SW_DOCK and SW_ROTATE_LOCK for example) so presumably we ought to
> handle them somehow too.
>
> It does sound like we need some input from the udev and more general
> userspace stack people about how this stuff is usually handled.

I was hoping for Lennart or Kay to answer here as they are more "udev 
and general userspace stack people" than I am, but lacking that, I can 
only notice that on my machine, the only processes listening to 
/dev/input files are upowerd (for the lid switch) and Xorg (for 
everything else). [1] Acpid seems to be able to listen to these events 
too, but does not seem to do that on my machine (as determined by "sudo 
fuser -v").

Xorg can only handle keypresses and mouse events, and AFAICT don't care 
about switch events, so, if the way things are usually handled is to add 
another u-audiojack-d just to forward events to pulseaudio, I would 
prefer giving the user access to the relevant input devices directly, 
out of pure simplicity.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] On a slightly older machine there is also hald-addon-input, but 
since that's deprecated, let's ignore that for now.
