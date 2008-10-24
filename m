From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: multiseat and alsa audio systems (usb headsets and
 usb audio adapters)
Date: Fri, 24 Oct 2008 14:44:59 +0200
Message-ID: <4901C34B.4060207@powercraft.nl>
References: <48FF675C.1060708@powercraft.nl>	<48FF8EF3.40200@powercraft.nl>	<74eb1fe20810221348y51fb9f85hbe00c5c5caa61a6f@mail.gmail.com>	<200810231256.40939.wishie@wishie.net>
	<49002B26.9020600@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node04.cambriumhosting.nl (node04.cambriumhosting.nl
	[217.19.16.165]) by alsa0.perex.cz (Postfix) with ESMTP id 3A91E2451D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 14:45:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by node04.cambriumhosting.nl (Postfix) with ESMTP id 10564B000060
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 14:45:02 +0200 (CEST)
Received: from node04.cambriumhosting.nl ([127.0.0.1])
	by localhost (node04.cambriumhosting.nl [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id jDCe23P201-p for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 14:45:01 +0200 (CEST)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by node04.cambriumhosting.nl (Postfix) with ESMTP id 19F31B00018E
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 14:45:01 +0200 (CEST)
Received: from [192.168.1.180] (unknown [192.168.1.180])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id E79B123BC65C
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 14:45:00 +0200 (CEST)
In-Reply-To: <49002B26.9020600@powercraft.nl>
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

Jelle de Jong wrote:
> Travis Place wrote:
>> On Thursday 23 October 2008 6:48:18 am Sean McNamara wrote:
>>> Hi,
>>>
>>> On Wed, Oct 22, 2008 at 4:37 PM, Jelle de Jong
>>>
>>> <jelledejong@powercraft.nl> wrote:
>>>> Sean McNamara wrote:
>>>>> On Wed, Oct 22, 2008 at 1:48 PM, Jelle de Jong
>>>>>
>>>>> <jelledejong@powercraft.nl> wrote:
>>>>>> Hello everybody,
>>>>>>
>>>>>> I have a four to eighth muliseat debian linux system here and it is
>>>>>> missing sound for the users. I was hoping the alsa team can help me
>>>>>> with this issue.
>>>>> All sound issues on Linux are extremely application-specific. Getting
>>>>> sound to work without any specific application in mind is asking for
>>>>> trouble, because there is no single configuration of the sound stack
>>>>> (which, if you expand into historical sound APIs and servers, contains
>>>>> about 20 different ways to play sound) that will satisfy any
>>>>> application without further configuration.
>>>>>
>>>>> Since this is not a really well-formed question, I will proceed with
>>>>> the assumption that you want to be able to run, for example,
>>>>>
>>>>> aplay /usr/share/sounds/pop.wav
>>>>>
>>>>> in the console, and have it produce sound in the "appropriate"
>>>>> headset. Here's how you proceed:
>>>>>
>>>>> 1. Each person on the multiseat box must have their own UNIX user
>>>>> account. 2. Each user account must have an ~/.asoundrc file.
>>>>> 3. Each ~/.asoundrc file must redefine the "default" device. How you
>>>>> redefine it depends on a lot of things:
>>>>> (a) Do you want _direct_ hardware access to the sound card, i.e. one
>>>>> application at a time?
>>>>> (b) Do you want to use ALSA's built-in software mixing, i.e. dmix?
>>>>> (c) How many channels?
>>>>> (d) Do you want to use PulseAudio?
>>>>> (e) Do you want to use JACK?
>>>>> (f) For each USB headset, what is its corresponding "raw device
>>>>> string"? This will be something like hw:n, where n is a number
>>>>> starting from 0, depending on the order in which the USB drivers
>>>>> initialize each USB controller.
>>>>>
>>>>> All of the above questions, and others, will determine exactly how
>>>>> each user configures their ~/.asoundrc file.
>>>>>
>>>>> The *extremely naive* (not recommended) example of an ~/.asoundrc is
>>>>> like:
>>>>>
>>>>> pcm.!default {
>>>>> card 3
>>>>> }
>> Would this not be:
>>
>> pcm.!default {
>> type hw
>> card 3
>> }
>>
>>
>> Also, depending on the order in which they are plugged in, depends on what 
>> card number they get assigned. If all USB headsets are the same, you run into 
>> more problems telling them apart.
>>
>> For example, if you plug them in a some random order, card3 might infact be 
>> going to the 5th seat of the system..
>>
>> You will need some way to uniquely identify EACH headset, and force its slot 
>> or index parameter to the required number.
>>
> 
> OK here we go, every usb device has an unique ID in his usb tree, this
> is the benefit of using usb devices. I am going to provide an example
> how this works with identical usb mouse and keyboards.
> 
> ls -hal /dev/input/by-path/
> pci-0000:00:13.5-usb-0:10.1:1.0-event-kbd -> ../event13
> pci-0000:00:13.5-usb-0:10.2:1.0-event-mouse -> ../event15
> pci-0000:00:13.5-usb-0:3.1:1.0-event-kbd -> ../event4
> pci-0000:00:13.5-usb-0:3.2:1.0-event-mouse -> ../event6
> pci-0000:00:13.5-usb-0:4.1:1.0-event-kbd -> ../event7
> pci-0000:00:13.5-usb-0:4.2:1.0-event-mouse -> ../event9
> 
> and then we can attached each input device to an specific task:
> Driver "evdev"
> Option "Path" "/././by-path/pci-0000:00:13.5-usb-0:10.1:1.0-event-kbd"
> 
> current system:
> cat /proc/asound/card
> 
> needed wanted requested system:
> /proc/asound/by-path/pci-0000:00:13.5-usb-0:4.3:1.0-card
> or
> /dev/audio/by-path/pci-0000:00:13.5-usb-0:4.3:1.0-card
> 
> and then in the users,
> 
> .asoundrc
> 
> pcm.!default {
>    type hw
>    card-bypath "/.../.../by-path/pci-0000:00:13.5-usb-0:4.3:1.0-card"
> }
> 
> So hereby my feature request, is this possible and well achievable, what
> would it take?
> 
> Best regards,
> 
> Jelle
> 
>>>>> to have ALSA clients play sound, by default, to the fourth sound
>>>>> device that happened to be initialized.
>>>>>
>>>>>> I have usb headsets and usb audio devices and all users have there own
>>>>>> usb hub. There are no internal audio cards in the multiseat server.
>>>>>>
>>>>>> How can we configure an system that the user can listen to audio only
>>>>>> to the devices connected to his usb hub.
>>>>> Well, this is guaranteed by design, isn't it? Without physical access
>>>>> to someone else's headset, how would I get access to the audio streams
>>>>> being played to that headset? I don't think this really expresses what
>>>>> your problem is.
>>>>>
>>>>> If we flip your question around, it might be a little more
>>>>> interesting: "How can we configure a system so that each user's
>>>>> applications will only play audio to that user's corresponding
>>>>> headset?"
>>>>>
>>>>> You can interpret this question in two ways:
>>>>> 1. "How can we _prevent_ users from playing sound to each other's
>>>>> sound cards?" [mutually untrust[ed/ing] users]
>>>>> or
>>>>> 2. "How can we configure the default settings so that, if untampered
>>>>> with, a user's applications will play sound to that user's own headset
>>>>> and not anyone else's?" [mutually trust[ed/ing] users]
>>>>>
>>>>> The lack of hardware mixing actually comes back to being a security
>>>>> benefit to user space control in this kind of situation. Recall that
>>>>> if I run
>>>>>
>>>>> aplay --device=hw:0 /usr/share/sounds/pop.wav
>> Couldn't we allow dmix, but just append to the users UID to the ipc key, with:
>>
>> ipc_key 123456
>> ipc_key_add_uid true
>>
>> in the dmix config stanza in .asoundrc for each user ?
>>
>>

Would it be possible to use udev to create specific cardX nodes that can
be used in the .asoundrc? /proc/asound/cardX

I have looked at some udev rules but hey seem to be for oss devices or
am I mistaken?

/etc/udev/rules.d/50-udev.rules

# ALSA devices
KERNEL=="controlC[0-9]*",       NAME="snd/%k"
KERNEL=="hwC[D0-9]*",           NAME="snd/%k"
KERNEL=="pcmC[D0-9cp]*",        NAME="snd/%k"
KERNEL=="midiC[D0-9]*",         NAME="snd/%k"
KERNEL=="timer",                NAME="snd/%k"
KERNEL=="seq",                  NAME="snd/%k"

KERNEL=="snd", SUBSYSTEM=="module", ACTION=="add", \
        RUN+="/bin/ln -sf /proc/asound/oss/sndstat $root/sndstat"

Kind regards,

Jelle

>>>>> then as long as the aplay program is playing sound to hw:0, it is
>>>>> *impossible* (short of some really devious hacking in alsa-lib or the
>>>>> kernel) for another application -- from this user, or another -- to
>>>>> also play sound to hw:0 at the same time. I'll call this claim "No
>>>>> Native SW Mixing".
>>>>>
>>>>> Now, let's look at what is required to satisfy the question in each of
>>>>> the two above cases.
>>>>>
>>>>> Trusted:
>>>>> 1. We know that users aren't going to maliciously try and hurt one
>>>>> another's ears by setting someone else's mixer really loud and playing
>>>>> static to them.
>>>>> 2. We know that users won't try to tamper with eachother's processes
>>>>> or configuration files; once things are configured correctly, it'll
>>>>> stay that way.
>>>>> 3. By 'No Native SW Mixing', we know that users can *theoretically*
>>>>> hog another user's sound device whenever that user has zero
>>>>> applications currently using it.
>>>>> 4. Since users trust each other, they won't do this.
>>>>> 5. We can use something like dmix, or just use hw:0 if users don't
>>>>> need simultaneous app output, and things will be fine.
>>>>> 6. dmix is a viable option to implement software mixing.
>>>>> 7. PulseAudio is also a viable option to implement software mixing.
>>>>>
>>>>> Untrusted:
>>>>> 1. Users may want to maliciously try and hurt one another's ears by
>>>>> setting someone else's mixer really loud and playing static to them.
>>>>> 2. Users may try to tamper with eachother's processes or configuration
>>>>> files; once things are configured correctly, it could get messed up
>>>>> again. [There's not much you can do to prevent this ... at least not
>>>>> based on existing open source tools.]
>>>>> 3. By 'No Native SW Mixing', we know that users can *theoretically*
>>>>> hog another user's sound device whenever that user has zero
>>>>> applications currently using it.
>>>>> 4. Since users do not trust each other, there is potential for 3 to
>>>>> happen. 5. We must use 'No Native SW Mixing' to our advantage, to create
>>>>> a walled garden around each user's sound experience. We need a process
>>>>> that, once started by a user, will permanently "hog" the sound card that
>>>>> user wants to use. This process should, ideally, allow other processes
>>>>> run by that user (and by that user only) to access their USB headset for
>>>>> output or input. We need a "gatekeeper" that is sensitive to the context
>>>>> in which an app is being run.
>>>>> 6. dmix is a NOT viable option to implement software mixing, because:
>>>>> (a) Once all dmix applications close their streams, the audio device
>>>>> hw:n is available, and some malicious user can decide to acquire it,
>>>>> abuse it, and prevent its rightful user from accessing it with his own
>>>>> applications.
>>>>> (b) dmix does not restrict users from outputting sound based on their
>>>>> UID or session. It is NOT a gatekeeper, just an open gate.
>>>>> 7. PulseAudio is [perhaps the best] viable solution to implement
>>>>> software mixing for each respective user. It is also a viable solution
>>>>> to preventing users from taking control of one another's sound
>>>>> devices.
>>>>>
>>>>> Configuring pulseaudio for a multi-soundcard multi-user system is out
>>>>> of the scope of this mailing list, but suffice it to say that it can
>>>>> be done. You will want to run one PulseAudio daemon per user, and each
>>>>> daemon will hold exclusive control over exactly one USB headset. Each
>>>>> daemon will only accept clients' requests for audio I/O from the user
>>>>> who started the daemon. Do make sure that you disable
>>>>> module-suspend-on-idle, or PulseAudio will actually give up the sound
>>>>> device after a period of inactivity, making it insecure in an
>>>>> untrusted environment.
>>>>>
>>>>> BTW, if this project is for a commercial interest, you usually pay
>>>>> someone for this kind of in-depth analysis. If you're that someone,
>>>>> you might want to read up on some of the underlying technologies so
>>>>> that you can develop this sort of reasoning on your own. I can
>>>>> envision a very real situation for both the trusted and the untrusted
>>>>> environment, so there is definitely a demand for this kind of
>>>>> specialist. Trusted environments are popular at workplaces, and
>>>>> untrusted multi-seat boxes are popular at computer labs, public
>>>>> libraries, etc.
>>>>>
>>>>>> Any help is really appreciated.
>>>>> Please let me know if this information was helpful -- it will help me
>>>>> gauge, in turn, whether I should spend my time writing up these sorts
>>>>> of answers on the ML. FWIW, I searched around for existing articles
>>>>> touching this subject, but I couldn't find anyone who addresses this
>>>>> specific issue accurately or in enough detail.
>>>>>
>>>>> Sean
>>>>>
>>>>> P.S. - I once spoke to a user on IRC who was having intermittent
>>>>> problems with multiple USB headsets. It turns out that the USB
>>>>> controllers in the computer didn't have enough bandwidth, or power (or
>>>>> both) to allow all of the headsets to play at once. If, after
>>>>> configuring, you run into issues where only so many users can play
>>>>> sound at once, then you should invest in additional PCI or
>>>>> (preferably) PCI-Express USB controllers. Note that adding hubs
>>>>> upstream of a USB controller does absolutely nothing to lessen the
>>>>> load on the USB controllers that are integrated into your motherboard.
>>>>>
>>>>>> Thank in advance,
>>>>>>
>>>>>> Jelle
>>>> Thank you Sean, this is by far the most extensive response i received in
>>>> months with an "open" question on an mailinglist, this really is a good
>>>> character, that I will reward if you sent an paypal address :-p.
>>> Ha ha, I appreciate the offer :) Yes, it was a very open question;
>>> that's why I didn't want to assume too much about your knowledge, and
>>> to answer you with something that would point you in the right
>>> direction if you were, in fact, ignorant of the basic situation here.
>>>
>>>> I have extensive experience configuring alsa and usb headset, little new
>>>> info was delivered for me but i think others will really like your
>>>> response too.
>>>>
>>>> My main issue is how to start alsa when there are no audio cards on the
>>>> system using debian sid? so i can use bluetooth or hotplug usb audio
>>>> devices...anybody?
>>> A "quick hack" would be to add 'snd' and 'soundcore' (and maybe other)
>>> kernel modules to /etc/modules. That way, on boot, ALSA will be in the
>>> kernel even if the initial probing routines don't find any sound
>>> hardware. Then, as long as your bluetooth and USB modules are loading
>>> correctly, the hotplug support should take over from there if your
>>> ALSA is recent enough.
>>>
>>>> Then I think it will become an udev issue to regulate a fixed group and
>>>> permissions for usb audio devices. I was kind of hoping somebody had
>>>> done this kind of udev ruling for usb audio devices and can provide some
>>>> examples this will save me time...anybody?
>>> Yes, definitely a udev issue if you want to restrict things at the
>>> ALSA level. Otherwise the permissions on the raw character devices
>>> /dev/snd/pcm* will be liberal by default.
>>>
>>> But if you're willing to move up into application space, I'm pretty
>>> sure one of PulseAudio's advertised features is to handle just this
>>> kind of ruling among different users and/or groups. You could
>>> certainly set this up so that the PulseAudio daemons for all the users
>>> are launched at boot time so that all of the audio devices are
>>> [permanently] "hogged" by their appropriate users before anyone has a
>>> chance to log in.
>>>
>>> And of course, PulseAudio is excellent with hotplug nowadays.
>>>
>>>> PS. I have also noticed usb audio problems (also posted them to irc
>>>> maybe 1 year ago) in the past with usb hubs and other kinds of things,
>>>> these things can brake an design or make it:-p
>>> Yes, the Win32 device manager has a nice little applet that shows the
>>> current bandwidth usage/availability for USB controllers... I'm not
>>> sure how accurate it is... but having something like this for Linux
>>> would be immensely useful as you are setting up the topology of your
>>> USB headsets. It would be nice not to have to empirically try and
>>> break the sound by playing all of the headsets at once...
>>>
>>>> So thank you very much for this great response, and keep up doing this
>>>> kind of work.
>>> Thanks for the encouragement!
>>>
>>> Sean
>>>
>>>> Kind regards,
>>>>
>>>> Jelle
