From: Gerard Janssen <g.janssen@its.tudelft.nl>
Subject: Re: How to select different S/PDIFoutput ports on a
 SBLive!
Date: Fri, 27 Sep 2002 17:00:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0H3300LLNR39QV@mailhost1.tudelft.nl>
References: <0H1P000C9NO5XV@mailhost1.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/html; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.33.0209011718250.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<html>
<font face="Courier New, Courier">Hi,<br>
<br>
In my attempt to address the four SPDIF output ports of the SBLive!, I
made the following changes in the the emufx.c code. I did not to use the
playback registers or SND_EMU10K1_PLAYBACK_CHANNELS (as far as possible)
since I would like to omit volume and tone control.<br>
<br>
if (emu-&gt;fx8010.extout_mask &amp;
((1&lt;&lt;EXTOUT_TOSLINK_L)|(1&lt;&lt;EXTOUT_TOSLINK_R))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IEC958 Optical Raw Playback
Switch */<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (z = 0; z &lt; 2; z++)
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SWITCH(icode, &amp;ptr, tmp + 0, 8 + z, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SWITCH(icode, &amp;ptr, tmp + 0, 8 + z, gpr + z);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SWITCH_NEG(icode, &amp;ptr, tmp + 1, gpr + z);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SWITCH(icode, &amp;ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS
+ z, tmp + 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
OP(icode, &amp;ptr, iACC3, EXTOUT(EXTOUT_TOSLINK_L + z), GPR(tmp + 0),
GPR(tmp + 1), C_00000000);<br>
}<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
snd_emu10k1_init_stereo_onoff_control(controls + i++, &quot;IEC958
Optical Raw Playback Switch&quot;, gpr, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpr += 2;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; if (emu-&gt;fx8010.extout_mask &amp;
((1&lt;&lt;EXTOUT_HEADPHONE_L)|(1&lt;&lt;EXTOUT_HEADPHONE_R))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Headphone Playback Volume
*/<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (z = 0; z &lt; 2; z++)
{<br>
OP(icode, &amp;ptr, iACC3, EXTOUT_HEADPHONE_L + z, GPR(z), C_00000000,
C_00000000);<br>
}<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
snd_emu10k1_init_mono_onoff_control(controls + i++, &quot;Headphone
Center Playback Switch&quot;, gpr + 2, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; controls[i-1].id.index =
1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
snd_emu10k1_init_mono_onoff_control(controls + i++, &quot;Headphone LFE
Playback Switch&quot;, gpr + 3, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; controls[i-1].id.index =
1;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpr += 4;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; if (emu-&gt;fx8010.extout_mask &amp;
((1&lt;&lt;EXTOUT_REAR_L)|(1&lt;&lt;EXTOUT_REAR_R)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (z = 0; z &lt; 2;
z++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
OP(icode, &amp;ptr, iACC3, EXTOUT(EXTOUT_REAR_L + z), GPR(4 + z),
C_00000000, C_00000000);<br>
<br>
&nbsp;&nbsp;&nbsp; if (emu-&gt;fx8010.extout_mask &amp;
(1&lt;&lt;EXTOUT_CENTER)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
OP(icode, &amp;ptr, iACC3, EXTOUT(EXTOUT_CENTER), GPR(6), C_00000000,
C_00000000);<br>
}<br>
<br>
&nbsp;&nbsp;&nbsp; if (emu-&gt;fx8010.extout_mask &amp;
(1&lt;&lt;EXTOUT_LFE)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
OP(icode, &amp;ptr, iACC3, EXTOUT(EXTOUT_LFE), GPR(7), C_00000000,
C_00000000);<br>
}<br>
<br>
With this code, I get the following result using aplay: &quot;spdif&quot;
is routed to SPDIF output#0, &quot;center_lfe&quot;&nbsp; --&gt; SPDIF
output#1, &quot;front&quot; --&gt; SPDIF output#2 and &quot;rear&quot;
--&gt; SPDIF output#3. This holds when wav-file is send to one of them
separately. When I send wav-files all of them simultaneously, there is a
conflict between &quot;spdif&quot; and &quot;center_lfe&quot;. The output
(&quot;spdif&quot; / &quot;center_lfe&quot;) that is first started is
used. The wav-file to the other output is played, but there is the
following message and no samples are send to the spdif output:<br>
<br>
Playing WAVE 'Track072.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo<br>
ALSA lib setup.c:94:(snd_sctl_install) Cannot lock ctl elem<br>
aplay: set_params:787: Unable to install hw params:<br>
ACCESS:&nbsp; RW_INTERLEAVED<br>
FORMAT:&nbsp; S16_LE<br>
SUBFORMAT:&nbsp; STD<br>
SAMPLE_BITS: 16<br>
FRAME_BITS: 32<br>
CHANNELS: 2<br>
RATE: 44100<br>
PERIOD_TIME: 100000<br>
PERIOD_SIZE: 4410<br>
PERIOD_BYTES: 17640<br>
PERIODS: 5<br>
BUFFER_TIME: 500000<br>
BUFFER_SIZE: 22050<br>
BUFFER_BYTES: 88200<br>
TICK_TIME: 10000<br>
<br>
It seems as if both &quot;spdif&quot; and &quot;center_lfe&quot; try to
access the same registers. Is this the case? How can it be solved? Which
GPRs contain the samples send to &quot;spdif&quot;?<br>
<br>
Regards,<br>
<br>
Gerard Janssen<br>
</font>
<BR>
</html>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
