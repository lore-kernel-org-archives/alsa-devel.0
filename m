From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-user] ALSA Newbie - Getting Ensoniq
 SoundscapeVivo to work?
Date: Sun, 29 Apr 2007 09:31:44 +0200
Message-ID: <463449E0.70909@gmail.com>
References: <d382e1990704272206y9712a84x1e07d07eda58fb18@mail.gmail.com>	
	<463319CA.4040309@gmail.com> <4633356F.9090404@opensound.com>	
	<4633CD22.9070305@gmail.com>
	<d382e1990704281918g42165aaas4cac717fe5b4bab0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d382e1990704281918g42165aaas4cac717fe5b4bab0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cody Jung <funkycat32@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/29/2007 04:18 AM, Cody Jung wrote:

> Er...that appears to be a .diff file. Do I have to do something with it
> for it to be workable, or...?

Yes. You'd have to apply the patch (as it's called) to a recent kernel
source tree, reconfigure the kernel adding this new VIVO driver to your
config and then recompile and reinstall that kernel.

Oh well, you posting to alsa-user and not alsa-devel should've been a hint.
Rest assured the driver would've worked nicely :-/

There is another thing you can do. What was posted was just a wrapper around
cs4231-lib in much the same way that the existing snd-cs4231 module is and
that module you _will_ already have installed. That one doesn't do anything
automatic though, so you will have to know how to manually enable your card
first.

First, open a root shell and look through the /sys/bus/pnp/devices directory
for your VIVO. Under the "xx:yy.zz" sub-directories there you will find "id"
files, and one of them will say "ENS1011". Example:

# cat /sys/bus/pnp/devices/01\:01.00/id
ENS1011

After having found it in there, activate the card:

# echo activate >/sys/bus/pnp/devices/01\:01.00/resources

and look at what resources were assigned to it by the PnP layer:

# cat /sys/bus/pnp/devices/01\:01.00/resources
state = active
io 0x330-0x33f
io 0x530-0x537
io 0x2100-0x213f
irq 5
irq 9
dma 1
dma 0

You can now load the snd-cs4231 module specifying those card resources manually:

# modprobe snd-cs4231 port=0x534 irq=5 dma1=1 dma2=0

Yes, 0x534. The second io resource + 4. This should've loaded without
problem. Start up alsamixer:

# alsamixer

and up and unmute the PCM volume. With -> and <- you can walk through the
sliders; ^ ups the one you're on, and "m" toggles the mute (the "MM" at the
bottom should turn to a highlighted "OO"). PCM is the first slider. 90 seems
to be an okay value.

Quit alsamixer again with Alt-Q and now you should be able to hear things.
If you have a plain "wav" file around somewhere, that makes for the quickest
test:

# aplay foo.wav

No, I'm not going to tell you to plug in your speakers.

If anything in the above doesn't work as expected, your system is not as
expected and there's isn't much I can help with. If everything does work,
you can automate it for the next time.

I've attached (to try and avoid linewrap) the lines that you will need in
/etc/modprobe.conf. Ubuntu has no doubt found a way to make that dark and
muddy again so you might need to add it to an /etc/modprobe/whatever file
instead. Please ask a fellow ubuntu victim for advice about translating this
generic linux advice to your install.

Once you do have that all setup, sound should "Just Work". You probably need
to adjust the volume as specified above once only after which ubuntu will
save it for the next boot, but if you don't hear anything ater rebooting,
please check that first.

Rene.
