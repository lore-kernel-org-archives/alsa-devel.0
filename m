From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA: Pin assignment experiment with ALC260
Date: Mon, 6 Feb 2006 12:35:57 +1030 (CST)
Message-ID: <200602060205.k1625vGs023735@auster.physics.adelaide.edu.au>
References: <acb0c1690602040905w623d7649l2214bb5fa41736f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <acb0c1690602040905w623d7649l2214bb5fa41736f6@mail.gmail.com> from "Paulo Matias" at Feb 04, 2006 03:05:12 PM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Paulo

> Sorry for the delay, I was crowded with work the last days..

No worries.

> Issued modules-update, then compiled the module with:
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
> 
> static struct hda_verb alc260_fujitsu_init_verbs[] = {
>   {0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x0F, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>   {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>   {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>   {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>   {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
> };

Hmm, that all looks reasonable.  Having another look at the datasheets I
now suspect that the lines

  {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},  
  {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},  
  {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},  

are unnecessary since I don't think these widgets have a mute on the output.
I'll look into that in the next day or so.  However, that shouldn't stop
them working since the verb will be ignored.

> Restarted the computer. No changes: only line and mic jacks working..
> the only change is that now I got output from the Mic jack, as I had
> set 0x12 to output.
> I've found:
> Line In Jack - pin 0x14
> Mic Jack - pin 0x12

Ok, so the things still missing in terms of external connections are output
to the internal speaker and to the headphone socket, right?

> Has I got no other results from that, I have added 0x15 to the list:
>   {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>   {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
> 
> No effects. I can't imagine what is happening... There is another pin
> beyond the pins I've put in the structure? What can be happening?

We'll keep 0x15 out of it for the moment since I very much doubt it is
involved.  It's rather strange that you haven't yet gotten any output from
the internal speaker or headphone jack.  Obviously the audio is being
produced or else you wouldn't have gotten anything out of the LineIn jack in
the above tests.  It's a puzzle since I can't see anything that you've
missed.  Takashi - is there something really obvious I'm missing here?

Ok, perhaps try the following.  Keep the mixer configuration as you had
it.  For the init verbs, use

  {0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
  {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},

  {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
  {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
  {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
  {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
  {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
  {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},

  {0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
  {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},

This verb list doesn't try to send pin complex verbs to 0x16 and 0x17 (which
don't understand them), doesn't mute the outputs of 0x08, 0x09 and 0x0a (as
discussed above) and starts 0x08, 0x09 and 0x0a unmuted.  After loading a
driver containing the above verb list you should get *something* out of the
headphone jack (and speaker) after turning up the 0x08 and 0x09 (and maybe
even 0x0a if things are really funky) volume mixer controls. If you still
don't get anything, perhaps try toggling the mixer's mute switches for 0x08
and 0x09 (ie: switch them once, and then do whatever is needed to make them
unmuted again if they aren't already).  This ensures things are in sync with
the mixer display and don't give rise to confusion.

If there's still nothing, maybe repeat the above exercise except replace
PIN_OUT with PIN_HP in all init verbs PIN_OUT appears in and try again.

A final thought - there isn't an external volume control on the laptop, is
there?

Let me know how you get on.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
