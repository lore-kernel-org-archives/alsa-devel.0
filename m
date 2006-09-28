From: Daniel Yek <dyek@real.com>
Subject: _test_channels() / plug:surround51 / Hardware Mixing
 And dmix / SW or HW Resampling / Volume Control
Date: Thu, 28 Sep 2006 01:54:47 -0700
Message-ID: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0670053880=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0670053880==
Content-Type: multipart/alternative;
	boundary="=_jor-el.real.com-12450-1159433557-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jor-el.real.com-12450-1159433557-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a lot of questions here; please feel free to pick and choose while 
answering them. I hope all questions will eventually be answered.

(A) Test Channels:

I have the following sound card.
Card: Intel ICH7
Chip: Analog Devices AD1981B
(AD1981B is AC '97 2.3 Compliant CODEC, 2 Channels of Audio with SPDIF)

Why the following code reports that the system supports 6 channels audio 
when the "default" device is used?
   channels = 6;
   snd_pcm_hw_params_test_channels( PCMHandle, hwparams, channels);

As a result, many channels were simply lost, not being heard. The same 
happens even on a 5.1 system if "default" device is used.

(B) Plug:

If opening "surround51" device failed, does it make sense for a media 
application to try to open "plug:surround51"?

Would "plug" play 5.1 channels content without losing any channel?

Or would it make more sense for the application to mix the channels into a 
2 channels output (in software)?

(C)  dmix:

Does ALSA use dmix if the sound card supports hardware mixing?

Are there different levels of hardware mixing supports? That is, if a sound 
card has hardware mixing support, does it always has 5.1 channel hardware 
mixing support?

ALSA library version 1.0.9rc2 and later is using dmix by default.
In the case of the sound card supporting hardware mixing, should a 
demanding media application prefers another device name because "default" 
is now configured with dmix?

If an application opens "surround51" device, would it hold the device 
exclusively and preventing other media application from using it?

If so, are they any standard dmix device name for surround51?


(D) Sampling Rate:

What is the best Sampling Rate to be produced by a media application for 
ALSA and ALSA dmix device?

The following page claimed that dmix write directly to the soundcard's DMA 
buffer.
Does that implicitly referring to sound card with hardware mixer?
http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php

The same page says that ALSA dmix device is default to RATE=48000.
With sound quality in mind, should a media application with resampling 
capability tries to resample to 48000Hz in software or should it let dmix 
or the hardware handle resampling?


(E) Volume Control:

How can I use ALSA's Playback controls volume level interface?
Is it for the application to use or more for alsa-lib?
Refer to http://www.sabi.co.uk/Notes/linuxSoundALSA.html

Are there any per-process Volume Control interface available?

Thanks very much.

-- 
Daniel

--=_jor-el.real.com-12450-1159433557-0001-2
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<html>
<body>
Hi,<br><br>
I have a lot of questions here; please feel free to pick and choose while
answering them. I hope all questions will eventually be
answered.<br><br>
(A) Test Channels:<br><br>
<pre>I have the following sound card.
Card: Intel ICH7
Chip: Analog Devices AD1981B
(AD1981B is AC '97 2.3 Compliant CODEC, 2 Channels of Audio with SPDIF)

Why the following code reports that the system supports 6 channels audio
when the &quot;default&quot; device is used? 
&nbsp; channels = 6;
&nbsp; snd_pcm_hw_params_test_channels( PCMHandle, hwparams, channels);

</pre>As a result, many channels were simply lost, not being heard. The
same happens even on a 5.1 system if &quot;default&quot; device is
used.<br><br>
(B) <pre>Plug:

If opening &quot;surround51&quot; device failed, does it make sense for a
media application to try to open &quot;plug:surround51&quot;?

Would &quot;plug&quot; play 5.1 channels content without losing any
channel? 

Or would it make more sense for the application to mix the channels into
a 2 channels output (in software)?

</pre>(C)&nbsp; <pre>dmix:

Does ALSA use dmix if the sound card supports hardware mixing?

Are there different levels of hardware mixing supports? That is, if a
sound card has hardware mixing support, does it always has 5.1 channel
hardware mixing support?

ALSA library version 1.0.9rc2 and later is using dmix by default.
In the case of the sound card supporting hardware mixing, should a
demanding media application prefers another device name because
&quot;default&quot; is now configured with dmix?

If an application opens &quot;surround51&quot; device, would it hold the
device exclusively and preventing other media application from using it?

If so, are they any standard dmix device name for surround51?


</pre>(D) <pre>Sampling Rate:

What is the best Sampling Rate to be produced by a media application for
ALSA and ALSA dmix device?

The following page claimed that dmix write directly to the soundcard's
DMA buffer. 
Does that implicitly referring to sound card with hardware mixer?
<a href="http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php" eudora="autourl">
http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php

</a>The same page says that ALSA dmix device is default to RATE=48000.
With sound quality in mind, should a media application with resampling
capability tries to resample to 48000Hz in software or should it let dmix
or the hardware handle resampling?


</pre>(E) <pre>Volume Control:

How can I use ALSA's Playback controls volume level interface?
Is it for the application to use or more for alsa-lib?
Refer to
<a href="http://www.sabi.co.uk/Notes/linuxSoundALSA.html" eudora="autourl">
http://www.sabi.co.uk/Notes/linuxSoundALSA.html

</a></pre>Are there any per-process Volume Control interface
available?<br><br>
Thanks very much.<br>
<x-sigsep><p></x-sigsep>
-- <br>
Daniel<br>
</body>
</html>

--=_jor-el.real.com-12450-1159433557-0001-2--


--===============0670053880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0670053880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0670053880==--
