From: Joachim Falk <joachim.falk@gmx.de>
Subject: [Fwd: Re: Control renaming for EMU10k1]
Date: Wed, 30 Jun 2004 21:42:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E317A3.8070701@jfalk.easynet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAFE0542DEE790F611EA250E0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFE0542DEE790F611EA250E0
Content-Type: multipart/mixed;
 boundary="------------080504060002080506030804"

This is a multi-part message in MIME format.
--------------080504060002080506030804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I seam to have forgotten to include alsa-devel list in my reply.

P.S.: Attached is a conversion about the EMU10k1 mixer I had with
        Peter Zubaj.

MfG
Joachim Falk

-------- Original Message --------
Subject: Re: Control renaming for EMU10k1
Date: Sun, 27 Jun 2004 00:31:45 +0200
From: Joachim Falk <joachim@jfalk.easynet.de>
To: Lee Revell <rlrevell@joe-job.com>
References: <40DD8775.2@jfalk.easynet.de>
<1088278410.24275.48.camel@mindpipe>

Lee Revell wrote:
| On Sat, 2004-06-26 at 10:25, Joachim Falk wrote:
|
|>With AC97 Sigmatel 9708/11. The names for the AC97 controls from
|>ac97_codec.c do not match how they are used on the Live.
|>So I have done some Control renaming in the emumixer.c
|>But the "AC97 Surround Playback control" is a stereo control
|>but is used for the Live as control for Center and LFE.
|>
|>So my question is how can i best rename this control to have two
|>different names matching the functionality for the right and left
|>channel of the stereo channel ?
|>
|>Or is driver hacking here foolish and there exists a better mechanisme
|>for this kind of stuff in userspace ?
|
|
| This is definitely an issue to be solved in userspace.  Many
| configurations do not use a center/LFE, and those that do may want to
| use a different pair of outputs.  Other configurations will have a
| full-range speaker (or a bass amp) connected to the LFE channel and will
| want to use a crossover/lowpass filter.
|
| The mixer for the EMU10K1 is actually an FX8010 DSP microcode program
| that is currently hardcoded in the driver.  Eventually this will be
| controlled by a userspace DSP patch loader/unloader.  Peter Zubaj has
| written such a program, ld10k1 (http://ld10k1.sourceforge.net).  It is
| "alpha-quality", but it can (for example) clear the DSP microcode and
| recreate the mixer configuration hardcoded in the driver.  The more
| people test it, the faster it will stabilize.
|
| I highly recommend you try the (Windows) driver from the kX Project
| (http://www.kxproject.com), or at least look at the screenshots and the
| docs.  They also distribute an SDK, the header files are interesting
| reading.  This should give you some idea of some of the amazing things
| this hardware is capable of and how far the ALSA driver has to go.  The
| ALSA driver is not as advanced as the kX driver yet, but this is being
| worked on.
|
|
|>My longterm goal is to improve the mixer for SB Lives.
|
|
| The best way you can help is to install ld10k1 and test it.  If you try
| the kX drivers then you will see that a stable DSP patch loader is
| required to do anything interesting with this card.  For the center/LFE
| issue, rather than tweaking the hardcoded DSP mixer code in the driver,
| this should let you make the changes to the 'mixer' DSP patch, then you
| can just load it in place of the default mixer.  The kX drivers use a
| patch called 'Surrounder' for this.
I allready have the ld10k1 and lo10k1 tools
here.
The mixers I speak about are AC97 controls
(AC97 is the Sigmatel 9708/11). And the surround channels
of this AC97 are used to drive the center and lfe channel on my
setup. DSP code has nothing to do with that as it can not influence
the names of the hardcoded AC97 control names.
Maybe one could than do in the kernel driver a renaming of the
mixers according to which output of the live card they control
(e.g. Yellow Analog connector Volume) And in userspace a renaming
of this mixer control to its functionality.
So is there a capability in the userspace libs of alsa do to
mixer renaming ?

|
| Finally, I do not speak for ALSA or the author of ld10k1, I just like to
| hack the driver.  The above is just my opinion.
|
| Lee
|
|
|
| -------------------------------------------------------
| This SF.Net email sponsored by Black Hat Briefings & Training.
| Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
| digital self defense, top technical experts, no vendor pitches,
| unmatched networking opportunities. Visit www.blackhat.com
| _______________________________________________
| Alsa-devel mailing list
| Alsa-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/alsa-devel
|




-- 
Joachim Falk <Joachim.Falk@gmx.de>

You can always tell a really good idea by the enemies it makes.
    --programmers' axiom


--------------080504060002080506030804
Content-Type: text/plain;
 name="irc-session-pzad.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irc-session-pzad.txt"

10:41 <Joachim> Are you Peter Zubaj
10:42 <pzad> yes
10:42 <pzad> I am
10:42 <Joachim> Hey
10:43 <Joachim> I think you have tried to contact me on #creative some days ago
10:43 <Joachim> about the emu10k1 issues
10:45 <pzad> I think, yes
10:46 <Joachim> :-)
10:46 <Joachim> Say whats development do you do for alsa
10:46 <Joachim> s/whats/what/
10:47 <pzad> same changes in emu10k1 driver for audigy (mixer)
10:47 <Joachim> I only started my exploration into alsa land because the mixer for the Live was very dissatisfying
10:47 <Joachim> I want to add something like a master mixer to the Live
10:48 <pzad> I changed mixer in alsa for audigy
10:48 <pzad> but I dont haev SB Live
10:48 <Joachim> Hmm I don't think there is a true hardware master mixer for the Live
10:48 <pzad> It is not needed
10:48 <Joachim> This would mean I have to emulate one in software in the driver
10:49 <pzad> not in software in driver - in DSP
10:50 <Joachim> Hmm I don't like that because the DSP should be freely programmable and not all signals are routed through the DSP I think
10:50 <Joachim> let me check my datasheet for the AC97 codec
10:50 <pzad> do not use AC97 codec mixer for master
10:50 <pzad> you need implement it in DSP
10:50 <Joachim> Hmm why ?
10:51 <pzad> because SB Live sot use AC97 for all channels
10:51 <Joachim> sot ?
10:52 <pzad> ahh, sb live is complicated
10:52 <Joachim> My SB Live uses AC97 for Left Right Center and LFE and another DAC for Surround  L,R
10:53 <pzad> you must use master from ac97
10:53 <pzad> for fron channel
10:53 <Joachim> The mixer controls for the my Live in alsa are also wrong
10:53 <Joachim> s/the//
10:54 <pzad> problem is thet sb live uses ac97 for input and for front chanels
10:54 <pzad> how is master vokin in windows ???
10:54 <Joachim> How many SB Live with different routing and codecs are there. I have an old Live and a newer one. But at the moment I test with my old Live
10:54 <pzad> working
10:55 <Joachim> Yes my old Live uses AC97 for Left Right Center and LFE and inputs are Line in and analog cd in and analog aux in and some more witch are
                not connected
10:55 <Joachim> See datasheet for AC97
10:55 <pzad> I know
10:56 <pzad> new sb live uses ac97 for all channels
10:56 <Joachim> Ok the old one uses an stac9708/11
10:56 <Joachim> and the new on the stac9758
10:56 <pzad> yes
10:57 <Joachim> Are there some more variant
10:57 <Joachim> If I get both my cards to work, do i have covered the whole range of Lives ?
10:58 <Joachim> Well I have both variant so I could test them both with my changes
10:58 <Joachim> s/variant/variants/
10:58 <pzad> I think yes
10:59 <pzad> problematic are analog signals
10:59 <Joachim> ?
10:59 <pzad> for them you need master in ac97
11:00 <pzad> for surround channels you must have master in dsp
11:00 <pzad> how is master working in windows ???
11:02 <pzad> and one thing, if you have questions on ld10k1 then you should ask me
11:02 <Joachim> Umm no idead, don't use Windows very often
11:03 <Joachim> I have only analog signal not the fancy digital outs
11:03 <Joachim> Well both my Lives have digital outs but I don't have equipment to connect to these ports
11:05 <pzad> you want master that controls front, surround, center/lfe channels at same time ???
11:06 <Joachim> Hmm, looking at the datasheets of the stac9708/11 the analog signals can only be routed to the DSP mixed or only one of them is routed to
                the DSP
11:07 <Joachim> Yes a master for my whole sound levels for front, surround, center/lfe channels at same time !
11:07 <Joachim> Does your Audigy mixer have those things ?
11:08 <Joachim> brb Coffee calls
11:09 <pzad> audigy is better, it uses external DAC for all channel and external ADC for analog inputs
11:10 <pzad> from AC97 it uses only analog part - not DAC or ADC
11:14 <Joachim> Hmm what does it use than from AC97 ?!
11:14 <Joachim> Only mixing of analog input sources ?
11:15 <pzad> yes
11:15 <pzad> and external ADC is connected to front output from AC97
11:15 <Joachim> an than from AC97 LineOut it has an ADC or what ?
11:16 <Joachim> I mean is the AC97 uses for input or output
11:16 <pzad> yes, and route from AC97 lineout to front speaker jack can be dissabled
11:16 <Joachim> Ok you allready answered that
11:17 <Joachim> So the front speaker jack can be drived by both the AC97 and another DAC
11:17 <pzad> yes
11:18 <pzad> sorry, lunch time, I'll be back after 1 hour
11:18 <Joachim> ok
12:17 <pzad> I am back
12:44 <Joachim> So am I
12:51 <pzad> I think it will be not a problem to implement PCM Master
12:54 <pzad> I think, this will be good start
12:55 <pzad> An you can remove PCM Playback from AC97 and implement it in DSP
13:02 <Joachim> Hmm PCM Master can be implemented in the DSP because all PCM Streams run across it
13:03 <Joachim> Or one could use the attenuation controlls of the individual voice channels of the EMU10K1
13:03 <Joachim> What do you think
13:04 <pzad> yes
13:04 <Joachim> The advantage of not using DSP code is independence of the loaded DSP code maybe someone whants to cusiomize it
13:05 <Joachim> For the MASTER control I will have to use AC97 Lineout Master because analog input signals should be covered too, oprr ?
13:05 <Joachim> s/oprr/or/
13:05 <pzad> yes
13:06 <pzad> but when you route analog signal to dsp, you can not set capture to Mix, because you will get digital loop - very bad sound
13:07 <Joachim> What do you think the PCM Master should influence only PCM streams from the Computer or digital inputs too ?
13:08 <Joachim> If PCM Master only influences PCM streams from the Computer you simply use the attenuations controlls of all the EMU10k1 channels and it
                should work equally well on Live and Audigy
13:08 <pzad> good question
13:10 <pzad> from name it should influence only PCM, but when you have digital speakers it should influence inputs too
13:12 <Joachim> Huh what have the type of Speakers to do with this ?
13:13 <Joachim> I think the question is do digital input streams count for PCM Master controll ?
13:13 <Joachim> Or do they fall under a separate controll
13:13 <Joachim> Histrorically the analog inputs didn't have anything to do whith PCM Master
13:14 <Joachim> So do we count the digital inputs under inputs (has nothing to do with PCM Master) or do we count them under digital (PCM) influenced by
                PCM Master
13:23 <Joachim> I would tend to count digital inputs under input (No PCM Master influence)
13:23 <pzad> ok
13:25 <pzad> maybe best way should be to make some hybrid Master control from AC97 master and PCM Master
13:26 <pzad> but for now PCM Master is ok
13:30 <Joachim> Hmm yes, but for the next step I will try to make a virtual PCM Master by trying to use the attenuation controlls of the EMU10k1 channels
13:31 <Joachim> And if that works I will see what to do next. That shouzld be enought to kepp me occupied for the next weekend, as I tend to habe only
                scant time fort things like that.
13:31 <pzad> you should maybe remove PCM (from AC97) control - look at emumixer.c, because this conntrol will by after new PCM Master
13:31 <Joachim> s/weekend/weekends/
13:32 <Joachim> Hmm you have patchjed the audigy mixer controlls ? What kind of controls does the audigy have ?
13:33 <Joachim> Yes I will have to do a renaming and rtemoving of the AC97 controlls as they are totally bogus for my Live
13:34 <pzad> look there http://alsa.opensrc.org/index.php?page=AudigyMixer
13:34 <pzad> and http://alsa.opensrc.org/index.php?page=AudigyMixerControls
13:35 <pzad> Audigy uses from AC97 only Line In, CD, Aux, Mic +20 dB
13:35 <pzad> all other controls are implemented in DSP
13:35 <pzad> Audigy uses from AC97 only Line In, CD, Aux, Mic +20 dB
13:35 <pzad> all other controls are implemented in DSP
13:40 <pzad> there are PCM xxxxxxx controls used only for multichannel sound
13:41 <pzad> and controls to control mirroring (Front, Center,  LFE, Surround)
13:41 <pzad> and they are independent

Some days later

15:38 <Joachim> Hey Peter
15:38 <pzad> hello
15:40 <Joachim> Say you dont mind if I would attach a log of this irc session to a message to alsa-devel to better explain what I intend to
                 do ?
15:40 <pzad> OK
15:41 <Joachim> Do you know what the status of the integrated lisp in alsa is
15:42 <Joachim> Its supposed to fix the mixer situation
15:42 <pzad> no, I don't
15:42 <Joachim> I suppose by mapping functionality oriented control to structure oriented ones
15:44 <pzad> I don't know
15:47 <pzad> I think there will be layer above current api for simple applications for playback and mixer
15:49 <pzad> I think best person for this kind of questions is Jaroslav Kysela. He is working on this (I think)
15:50 <Joachim> Well the problem with renaming the AC97 controls is you don't know what speakers people have connected to their outputs
15:50 <Joachim> So the best you can do with these control is to name them according to the output they control, because this is structure
                and should be
15:51 <Joachim> the same on each setup
15:51 <Joachim> e.g. Yellow Connector Analog Volume for the AC97 mixer witch control the volume to the yellow connector on the back of the
                EMU10k1
15:52 <Joachim> (I think its yellow haven't looked)
15:53 <pzad> but what you want to control is for example front volume
15:55 <pzad> when this will call yellow conector volume, user must look at computer back where to what speakers it is connected
16:01 <Joachim> Well that was the question with the alsa lisp code and mapping from structure to functionality (yellow => structure) (front
                speaker => functionality)
16:07 <pzad> problem is that for new AC97 codecs you can change for jack function (front to rear speakers), and output to input - front
             speakers to mic
16:16 <Joachim> Well than of course you could no longer name the mixer controls like the outputs because they are no longer structurally
                fixed connected to output
16:16 <Joachim> but you can name name PCM stream1 volume and than do an enumerator control 'Yellow connector stream selector'
16:18 <Joachim> The problem how much of the underlying hardware complexity to expose via the controlls
16:18 <pzad> Front volume control should always control front volume
16:18 <pzad> yes, this is right problem
16:18 <Joachim> Well there is no control front volume because in the driver you do not have the knowledge on which connector the front
                speakers are connected to
16:20 <Joachim> If you want controls which the correct name from the driver in the kernel the module need parameters which decide which
                output connector is connected to which speaker
16:20 <pzad> ahh, front volume you mean front jack on computer case ???
16:20 <pzad> for me front was front speakes
16:20 <Joachim> No I mean 'front volume' the volume for the speaker in front of you
16:20 <pzad> s/speakes/speakers
16:21 <Joachim> And you have no data where these speakers are physically connected to you card
16:21 <pzad> then you always know this
16:21 <Joachim> ofcourse there are standard for this connecto with this color that speaker on so on
16:21 <pzad> or you should know this
16:21 <Joachim> but there are people which swap this because some output channels have better DACs and they want thius channel to control
                that speaker
16:22 <pzad> yes, but this must by supported by drivers
16:22 <Joachim> why
16:23 <Joachim> A sound card is simple a complex DAC
16:23 <pzad> there should by switch swap front and rear and Front still should control front
16:23 <Joachim> This is only a simple subcase of the more cdomplex case
16:23 <Joachim> The more complex case that you have to partameterise the kernel driver with this info
16:23 <Joachim> And this gets too complex fast
16:24 <Joachim> So the ideas seams to be to do that in userspace as far as I have gathered
16:24 <pzad> but when you swap speakers, there must be way to tell this to drivers
16:24 <pzad> I think yes
16:24 <Joachim> Well jein (German for Yes/No)
16:26 <Joachim> If the driver is only a complex DAC than you can do these in userspace the alsalib maps the control names from structure to
                functionality and you can decide which PCm stream to open allready decide via aliases in alsa.conf
16:26 <Joachim> If you have a more complex card like the EMU10k1 than you have to contact the driver to tell them the functionality of each
                FX bus
16:27 <Joachim> to which speaker the data will be targeted to
16:28 <pzad> yes, and for this I am working on ld10k1
16:34 <pzad> look at ice based sound card
16:34 <Joachim> Hmm ice based sound card ?
16:35 <pzad> you can control alsa mixer to control volumes and settings on this card, but better is use envy24control  program
16:35 <pzad> ice 1712/1724
16:35 <pzad> alias envy24
16:36 <Joachim> Say can you allready redefine what functionality the output registers of the FX8010 have
16:37 <Joachim> I mean these outputs are mapped to the DACs and AC97 and than to the output connectors
16:37 <pzad> not you can't
16:38 <Joachim> If swap speakers on your outputs you could also swap the meaning of these ports
16:38 <pzad> but for new sb live (2003) you can, because it use new ac97 codec
16:39 <pzad> for audigy you must change dsp program
16:39 <Joachim> Well :-) It depends you load your patch
16:39 <Joachim> and you allready do some type of dynamic linking
16:39 <pzad> yes
16:39 <pzad> and yes
16:40 <Joachim> Well how are the outpurt ports in the patches referenced
16:40 <Joachim> You could say port number xx has allways functionality yy
16:41 <Joachim> and than when you load the patch you could simply change the output port number the real port which has these functionality
16:41 <Joachim> So your patch file wouldn't change if you swap speakers
16:41 <pzad> for ld10k1 all pathces are independent, they have inputs and outputs and you can connect these ins and outs to FX8010 inputs
             and outputs
16:42 <pzad> I can rename inputs and outputs in ld10k1
16:42 <Joachim> Hmm rename ?
16:43 <pzad> you must change connections


--------------080504060002080506030804--

--------------enigAFE0542DEE790F611EA250E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4xepKwZcgs55jUMRAiHYAKD6DE1UMJZuL3VJFU7sbulnR2HfWQCfZglV
Y4fv6OGRUIm5s/LHDkPF5oQ=
=qeze
-----END PGP SIGNATURE-----

--------------enigAFE0542DEE790F611EA250E0--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
