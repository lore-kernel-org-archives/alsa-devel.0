From: Jochen Voss <voss@seehuhn.de>
Subject: microphone stereo input troubles
Date: Sun, 10 Sep 2006 23:29:45 +0100
Message-ID: <20060910222945.GA2749@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1815502423=="
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
To: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1815502423==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear ALSA developers,

I seem to have immense trouble getting stereo input from a microphone
to work.  I tried many things, and all of my attempts showed one kind
of trouble or another.  I would like to find out whether all of this
are separate problems or whether I am just spatially challenged.

Here is what I observed (alsa-driver version is hg20060907):

0) I triple-checked that my speakers are not swapped.  Everything
   seems to be ok there: the left/right channels of the volume control
   correspond to the correct speaker and "speaker-test -c 2" works ok.
   Thus the following problems cannot be explained by swapped
   speakers.


1) I tried to connect a Sony ECM MS907 microphone [1] via a Belkin
   iMic USB adapter [2] (supported by the snd_usb_audio module).  This
   was my most successful attempt: I could record a stereo signal from
   the microphone.  Problem: left and right input is exchanged.  If I
   blow at the microphone from the side labelled "L" the volume at the
   right speaker is loudest, if I blow at the microphone from the side
   labelled "R" the volume at the left speaker is loudest.  Why are
   the channels swapped?

   [1] http://www.sony.co.uk/view/ShowProduct.action?product=3DECM-MS907&si=
te=3Dodw_en_GB&pageType=3DOverview&category=3DACC+Microphones
   [2] http://seehuhn.de/comp/hardware/imic


2) I tried to connect the microphone to the microphone input of my
   ASUS A8V mainboard [3].  The board has a VT8327 chipset and is
   supported by the snd_via82xx module.  Recording sound works, but
   the signal seems to be mono (the two channels are the same or
   almost the same).  Does the VT8327 chipset support stereo
   recording?

   [3] http://seehuhn.de/comp/hardware/asus

3) I tried to connect the microphone to my Revolution 5.1 card [4],
   supported by the snd_ice1724 module.  I can record, but the
   recording seems to be mono again: the signals on the two channels
   are the same or almost the same.  The Revolution is, I think,
   supposed to be able to record in stereo.  Is this true?

   [4] http://seehuhn.de/comp/hardware/revolution

4) The card a stereo capture volume control.  I seem to be unable to
   control the capture volume separately from the output volume using
   amixer.  Example:

    tarte:~# amixer -c 0 set "PCM" 0%,100%=20
    Simple mixer control 'PCM',0
      Capabilities: pvolume cvolume cswitch cswitch-joined
      Playback channels: Front Left - Front Right
      Capture channels: Front Left - Front Right
      Limits: Playback 0 - 127 Capture 0 - 151
      Front Left: Playback 0 [0%] Capture 0 [0%] [on]
      Front Right: Playback 127 [100%] Capture 151 [100%] [on]

   The above command sets the volume for capture and output
   simultaneously.  I did not find a way to get output 100% on both
   channels and input 100% left, 0% right with amixer.  How can I do
   this?  Is it a good idea the 'PCM' combines the front speakers with
   the captuer channel anyway?

5) I can control the capture volume with alsamixer and display the
   result with amixer.  But here left and right channel are swapped.
   When I have

    tarte:~# amixer -c 0 get "PCM"=20
    Simple mixer control 'PCM',0
      Capabilities: pvolume cvolume cswitch cswitch-joined
      Playback channels: Front Left - Front Right
      Capture channels: Front Left - Front Right
      Limits: Playback 0 - 127 Capture 0 - 151
      Front Left: Playback 127 [100%] Capture 0 [0%] [on]
      Front Right: Playback 127 [100%] Capture 151 [100%] [on]

   the recording has only sound in the left channel.  And when I have

    tarte:~# amixer -c 0 get "PCM"
    Simple mixer control 'PCM',0
      Capabilities: pvolume cvolume cswitch cswitch-joined
      Playback channels: Front Left - Front Right
      Capture channels: Front Left - Front Right
      Limits: Playback 0 - 127 Capture 0 - 151
      Front Left: Playback 127 [100%] Capture 151 [100%] [on]
      Front Right: Playback 127 [100%] Capture 0 [0%] [on]

   the recording has sound only in the right channel.  Why is this
   swapped?

6) For comparison: same setup as in step 2 above, i.e. microphone
   plugged into the mainboard.  amixer shows a stereo control for the
   capture volume alone.  I can use this control to mute either
   channel of the input:

    tarte:~# amixer -c 1 set Capture 100%,0%
    Simple mixer control 'Capture',0
      Capabilities: cvolume cswitch cswitch-joined
      Capture channels: Front Left - Front Right
      Limits: Capture 0 - 15
      Front Left: Capture 15 [100%] [on]
      Front Right: Capture 0 [0%] [on]

   The above mutes the right input channel.

    tarte:~# amixer -c 1 set Capture 0%,100%
    Simple mixer control 'Capture',0
      Capabilities: cvolume cswitch cswitch-joined
      Capture channels: Front Left - Front Right
      Limits: Capture 0 - 15
      Front Left: Capture 0 [0%] [on]
      Front Right: Capture 15 [100%] [on]

   The above mutes the right left channel.  Thus, this works.

Any help in further diagnosing and fixing these problems would be very
welcome.

Many thanks,
Jochen
--=20
http://seehuhn.de/

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBJHZf+iD8yEbECURAtdsAJ9ygT8yauyii2yJxzHGILMTmNjAIgCg1OnH
SKiOMb0i6J4UgHi+tDoOcnc=
=IHYN
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


--===============1815502423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1815502423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1815502423==--
