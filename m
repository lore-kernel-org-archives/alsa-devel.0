From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Patch to fix LIN_OUT1 on Audigy2 cards (+ others)
Date: Tue, 18 Mar 2003 22:13:12 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303182213.12650.adq_dvb@lidskialf.net>
References: <200303120648.HAA27496@www1.pobox.sk> <200303122216.33901.adq_dvb@lidskialf.net> <20030318051812.GA1810@znex>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4n5d+1tCzqLVEfy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030318051812.GA1810@znex>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark J Roberts <mjr@znex.org>
Cc: p z oooo <pzad@pobox.sk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_4n5d+1tCzqLVEfy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 18 March 2003 05:18, Mark J Roberts wrote:
> I noticed that I can play back the audigy2-drive RCA SPDIF input by
> turning up the "Optical IEC958" slider, and "arecord -f dat out.dat"
> will record it.
>
> So, good. Just posting some more random info.

Cool, I'll add that to my list
BTW, attached is my current state of analysis of the mixer devices.. not 
complete yet (been very busy recently).

If you can be bothered, can you confim what I've got so far?

-- 
adq
--Boundary-00=_4n5d+1tCzqLVEfy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mixer_devices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mixer_devices.txt"

Audigy 2 mixer controls
-----------------------


? Master
? Master Mono
* Tone

  Switch to enable tone controls
  Umuted: enabled
  Muted: disabled

* Bass

  Controls output Bass.

* Treble

  Controls output Treble.

? 3D Control Switch
? 3D Control Depth
? PCM
? Surround
? Center
? LFE
* Wave

  Master control volume of PCM data (and ONLY PCM data).
  Volume controls work.

? Wave Capture
? Wave Center
? Wave LFE
? Wave Surround
? Music
? Music Capture
* Line

  Controls input from LIN_IN on card.

  Mute/unmute works.
  Volume controls work.
  Needs to be selected as a capture input.

* Line2

  Controls input from "Line 2"/"Mic 2" on drive.
  Volume controls work.

? Line2 Capture
* CD

  Controls input from CD_IN on card.
  Mute does not work.
  Volume does not work.
  Needs to be selected as a capture input.
  Volume is controlled by Capture+AC97.

? Mic
? Mic Boost
? Mic Select
? Video
? Phone
? PC Speaker
* Aux

  Controls input from AUX_IN on card.
  Volume does not work.
  Needs to be selected as a capture input.
  Volume is controlled by Capture+AC97.

* Aux2

  Controls input from Aux In 2 on drive.
  Volume controls work.

? Aux2 Capture
? Mono Out
* Capture

  Provides master control for all capturing.

  Volume control works and affects all captures.
  Select as a capture device to enable capture. Deselect to disable all capturing.

? Mix
? Mix Mono
? AC97
? AC97 Capture
* Audigy Analog/Digital Output Jack

  Controls switch between output on LIN_OUT1, LIN_OUT2, LIN_OUT3 and Digital-out-jack on card.
  Needs the special creative speakers to take advantage of digital (Audigy/2 cannot encode AC3)
  Can also passthrough pre-encoded AC3 (e.g. from a DVD)

  Unmuted: Analogue output
  Muted:   Digital output through

* Audigy CD

  Controls input from CD_SPDIF connector.

? Audigy CD Capture
? External Amplifier Power Down
? Optical IEC958
? Optical IEC958 Capture
? RCA SPDIF
? RCA SPDIF Capture

--Boundary-00=_4n5d+1tCzqLVEfy--



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
