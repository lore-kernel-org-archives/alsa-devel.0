From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA: Pin assignment experiment with ALC260
Date: Thu, 2 Feb 2006 10:52:33 +1030 (CST)
Message-ID: <200602020022.k120MXhp005529@auster.physics.adelaide.edu.au>
References: <acb0c1690602011152t458941ffqec82e99bca27aa3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <acb0c1690602011152t458941ffqec82e99bca27aa3c@mail.gmail.com> from "Paulo Matias" at Feb 01, 2006 05:52:32 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paulo Matias <syscoder@gmail.com>
Cc: jwoithe@physics.adelaide.edu.au, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Paulo

Note: forwarded to alsa-devel for info and archival purposes in connection
with bug 1618.

> I've been reading your messages at the ALSA bugtracking system for bug
> #1618, and was very interested in the pin assignment experiment you
> have done in Fujitsu notebooks. I've a Acer TravelMate 4062WLMi with
> the ALC260 chipset and was suffering from the same problem. So I've
> tried to do your experiment.

Cool.

> First the Kernel version ;)
> $ uname -a
> Linux 1 2.6.15-gentoo-r1 #6 PREEMPT Tue Jan 31 14:08:07 BRST 2006 i686
> Intel(R) Pentium(R) M processor 1.73GHz GenuineIntel GNU/Linux

Ok, that's good.  You're starting with a reasonably up-to-date ALSA.

> The audio peripheral I've is: integrated microfone, internal speaker
> and 3 jacks at the front: line, mic and headphone.

Right.  Out of interest, is the "line" jack promoted/labelled as a line
out or a line in (not that it will matter in the long run)?

> As with Fujitsu model I could get output from the line jack, I've used
> it as a base.

Good.  At least we know for sure that the basic sound layers are working.
That makes things easier.

> > add mixer controls for all the output widgets of the ALC260 chip to the mixer definition - alc260_base_output_mixer
> 
> So I've done:
> 
> static snd_kcontrol_new_t alc260_fujitsu_mixer[] = {
> 	HDA_CODEC_VOLUME("0x08 Volume", 0x08, 0x0, HDA_OUTPUT),
> 	HDA_BIND_MUTE("0x08 Switch", 0x08, 2, HDA_INPUT),
> 	HDA_CODEC_VOLUME("0x09 Volume", 0x09, 0x0, HDA_OUTPUT),
> 	HDA_BIND_MUTE("0x09 Switch", 0x09, 2, HDA_INPUT),
> 	HDA_CODEC_VOLUME_MONO("0x0A Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
> 	HDA_BIND_MUTE_MONO("0x0A Switch", 0x0a, 1, 2, HDA_INPUT),
> 	{
> 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> 		.name = "Capture Source",
> 		.info = alc_mux_enum_info,
> 		.get = alc_mux_enum_get,
> 		.put = alc_mux_enum_put,
> 	},
> 	{ } /* end */
> };

Ok, that looks sensible as a starting point.

> > Then add initialisation verbs for each of these widgets to the alc260_init_verbs list, making each of them an output.
> 
> So I've done:
> 
> static struct hda_verb alc260_fujitsu_init_verbs[] = {
> 	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x0F, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
>   {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>         {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>         {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>         {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>         {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>         {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>         {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
> };

A few comments:

 1) Any reason why widget 0x12 ("mic-1") isn't set as an output for these
    tests?

 2) I notice that you do something with widget 0x15 ("line-2").  I found
    that doing certain things with 0x15 caused all sound to be blocked until
    a reboot occured.  I'm wondering whether this is part of your problem. 
    This widget is unlikely to be connected to anything in this machine
    anyway, so if I was you I would avoid doing anything to it, at least
    until everything else is working.

 3) You only unmute pin widgets 0x10, 0x12 and 0x14.  It is probably a good
    idea to also unmute the others (0x0f and 0x13 in particular), at least
    until we know for sure that these don't go anywhere.  Although I
    never tested it, I think you could also put mute switches into the mixer
    for these pin widgets.  Eg:
      HDA_BIND_MUTE("0x0f Switch", 0x0f, 2, HDA_INPUT)
      HDA_BIND_MUTE("0x13 Switch", 0x13, 2, HDA_INPUT)
    However, I'd be tempted to do this after we know whether unmuting these
    in the init verbs has had any impact since I haven't tested the above
    and therefore don't know if there are any issues.

> With the changes I've made, I only got output from the line jack. I
> can't get output from the internal speakers nor from the headphone
> jack.

Obviously the first thing I'd do would be to remove the configution of 0x15
and reboot.  Also make completely sure that when you test these changes load
the hda with the "model=fujitsu" parameter since it is the fujitsu things
that you are changing (having said this I note that other changes you made
to test inputs did have an effect, so I suspect you're already doing this
bit correctly).

I think the next thing to test is to address point 3.  Since you get output
from the Line jack we can assume that it is connected to either 0x10 ("hp
out"), 0x12 ("mic 1") or 0x14 ("Line 1") since these are currently the only
3 pin widgets you have unmuted.  Using your mixer controls you should be
able to narrow this down to the exact widget.  Because there is no output
from the hp jack or the internal speaker by immediate thought is that
perhaps these are connected to other pin widgets.  By unmuting 0x0f and 0x13
and putting switches for these into the mixer as well you'll be able to test
these two possibilities.

My guess is that either the hp jack or the internal speaker is connected
to 0x0f.  You might even find that they both are, with a hardware switch
between them.  You'll have to experiment to see how it behaves once you
are able to get some noise out of them.

> 0x08 gives me control over the output in the line jack, but 0x09 and
> 0x0A apparently does nothing.

That wouldn't surprise me.  0x08 controls the internal LOUT1 bus, while 0x09
controls the internal LOUT2 bus.  0x0a is connected directly to the "mono"
output pin which, in most laptops seems to go nowhere.  I think "mono"
exists more for use on desktop mainboards where it would be an excellent
candidate for a subwoofer output.

There are a few things to note.  You'll notice that most of the output pin
widgets (excepting 0x0f, 0x10 and 0x11) have a selector to their left which
switches their input between the two internal output buses (LOUT1 and
LOUT2).  The default state is to take input from LOUT1.  Thus 0x08 will
control the output level from *most* of the pin widgets (assuming they are
configured as outputs of course).  It is worth noting that despite
appearances to the contrary, the selectors feeding 0x12, 0x13, 0x14 and 0x15
are not actually part of the pin widgets - they have their own NIDs (0x0b,
0x0c, 0x0d and 0x0e andrespectively), but these were omitted from the block
diagram on page 4 of the datasheet.  They're mentioned in passing in the
"Get connection select" control section of the datasheet (section 8.2, page
30-31 if you're interested).

The pin widgets 0x0f, 0x10 and 0x11 function a bit differently to the others
though.  I've already talked about 0x11.  You'll see that 0x10's (HP out)
input is hardwired to 0x09 while 0x0f (Line out) is hardwired to 0x08.
I suspect this situation has been done to make life easier for integrators.
If they use 0x10 as the headphone output and 0x0f as the line output, then
there's nothing special to do in order to have separate volume controls
for each of these.

> I've tried to add {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}
> to alc260_fujitsu_init_verbs and 	HDA_CODEC_VOLUME("Mic Playback
> Volume", 0x07, 0x0, HDA_INPUT), HDA_CODEC_MUTE("Mic Playback Switch",
> 0x07, 0x0, HDA_INPUT) to alc260_fujitsu_mixer. With these changes, I
> could get input from the integrated microphone and from the microphone
> jack (when there is no microphone plugged in the jack, it gets the
> input from the integrated microphone, but when I plug a microphone in
> the jack, it switchs the input automatically to the jack).

Right.  Actually this is a good outcome I think.  It shows that 0x12 is
connected to the "mic" jack.  I suspect the "mic" jack is a mono jack btw;
with most laptops "mic" is synonymous with "mono input".

This *probably* also indicates the switching happens in hardware rather than
in software, since with the "fujitsu" model in use there is no auto
retasking in use.  This adds weight to the above hypothesis that the HP jack
switches the internal speaker off in hardware when a jack is plugged in.

> Sorry, but I really think I've don't understood your instructions. I
> think I've done all the whole thing wrong. :)

No, I think you've done pretty well actually.  You've already shown that
the "mic" jack is connected to pin widget 0x12 in this laptop, and we know
that the "line" jack is therefore connected to either 0x10 or 0x14 (and some
operation of the mute switches in your mixer configuration should allow
you to nail which it is).  All we have left is to work out what's going
on with the internal speaker and hp jack, as described in detail above.

> The things I've to fix now are: more urgently, internal speakers

This will probably come out in the wash.

> and CD playing

I am almost certain that the CD drive will be connected to the "CD" input
pin of the ALC260 (widget 0x0x16).  Once we get the outputs sorted out
we'll tackle this, but I don't think it will be a major issue.  In short,
simply adding

  HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),
  HDA_CODEC_MUTE("CD Playback Switch", 0x07, 0x04, HDA_INPUT),

to the mixer definition you're currently using should be sufficient to get
it working (although an explicit initialisation verb won't hurt).  However,
let's get output working first and then move on to other things - if for no
other reason than to keep the number of variables low. :-)

> the headphone jack (as I can plug the headphone in the line jack by now,
> but I think the line jack have been designed for input, not for output).

Again, I think we'll get this sorted fairly quickly if you run through the
things I've mentioned above.  As to your comment about the line jack being
designed for input, you'll note that the datasheet says that the pin widget
this is connected to (0x12) is a "retasking" pin.  This means it can be
switched to be an input or an output under software control. For laptops
equiped with 2 stereo jacks (as yours seems to be and mine is), this and the
fact that the ALC260 actually has two independent stereo ADCs means that
it's possible to do four channel multitrack recording on these laptops. 
I've actually successfully done this for a show already and am in the
process of tidying up my hack for inclusion in ALSA (the hack dates from
late December 2005; now I've cleared a few time-critical projects such as a
DVD production I'm hoping to get to this in the next week or so).

> So, can you please give me more detailed instructions? Then I will make
> the other audio peripherals work and send a patch to the ALSA project. :)

As I mentioned I think we're almost there.  Once we do know what goes where
we'll compare the result with existing models.  If it's similar it might
be possible to piggyback off one of them; otherwise it'll be a case of
adding a new model like I did for "fujitsu".

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
