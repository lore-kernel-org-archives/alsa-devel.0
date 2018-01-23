From: Charles Mulder <keyboardcolab@gmail.com>
Subject: Best course of action with Audient iD14
Date: Tue, 23 Jan 2018 07:04:15 +0000
Message-ID: <CALVpPLHpUS3GX8gPq_c2RhDVP_3YY-y2Tv2E-SF0tj+uHNN94A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6104762870893253040=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/alsa-user>,
 <mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
 <mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============6104762870893253040==
Content-Type: multipart/alternative; boundary="001a113f810230bffb05636c286a"

--001a113f810230bffb05636c286a
Content-Type: text/plain; charset="UTF-8"

Hi.

I recently bought the Audient iD14, which is a class compliant USB2 device.

I would like to use it for writing and record music. Apparently it has
great converters.

After some online searching I came across a similar question on
StackOverflow
<https://askubuntu.com/questions/714280/ubuntu-thinks-my-audient-id14-audio-interface-is-analogue-surround-4-0-when-its>
:

*Question*
"Ubuntu lists my audio interface as Analogue Surround 4.0 when it actually
only plays in stereo. As a result, the audio plays louder in the right
channel than the left channel."

*Answer*
*"Ubuntu (Linux in general) is correct in assigning 4 outputs as there are
4 outputs on the iD14. As you and I both know, only one pair of outputs are
physically accessible. Outputs 3&4 are primarily used to send alternate
mixes to musicians and are only accessible via the Audient mixer and/or
DAW. The iD14 is class compliant in as far as it is recognised and some
audio can be heard. Unfortunately that is as far as it goes (currently) as
there is no mixer available to ALSA or Pulse etc. If you open a terminal
and run alsamixer, press F6 and select Audient iD14, it will report a
broken pipe error. ALSA (or Pulseaudio) has no way of knowing how to
allocate the outputs, so assumes all 4 detected outs are available, but
also has no way of directing signal appropriately."*

I would like to ask your help to establish what the best course of action
would be.

Should I work on trying to fix this issue with a custom .asoundrc
<http://www.alsa-project.org/main/index.php/Asoundrc> file, possibly using
the multi plugin
<http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_multi>
?

If that's not possible, what would writing a ALSA USB driver specifically
for the Audient iD14 entail?

iD14 manual and specifications
<https://audient.com/products/audio-interfaces/id14/downloads/>

I would appreciate your thoughts and insights on this.

Kind regards,
Charles Mulder



-- 
Charles Mulder
Software Engineer/Musician
mobile: +27 83 653 3698
phone: +27 27 948 2592
skype: charliemurder

--001a113f810230bffb05636c286a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi.=C2=A0=C2=A0</div><div><br></div><div>I recently b=
ought the Audient iD14, which is a class compliant USB2 device.</div><div><=
br></div><div>I would like to use it for writing and record music. Apparent=
ly it has great converters.=C2=A0</div><div><br></div><div>After some onlin=
e searching I came across <a href=3D"https://askubuntu.com/questions/714280=
/ubuntu-thinks-my-audient-id14-audio-interface-is-analogue-surround-4-0-whe=
n-its">a similar question on StackOverflow</a>:</div><div><br></div><div><b=
>Question</b></div><div>&quot;Ubuntu lists my audio interface as Analogue S=
urround 4.0 when it actually only plays in stereo. As a result, the audio p=
lays louder in the right channel than the left channel.&quot;</div><div><br=
></div><div><b>Answer</b></div><div><i>&quot;Ubuntu (Linux in general) is c=
orrect in assigning 4 outputs as there are 4 outputs on the iD14. As you an=
d I both know, only one pair of outputs are physically accessible. Outputs =
3&amp;4 are primarily used to send alternate mixes to musicians and are onl=
y accessible via the Audient mixer and/or DAW. The iD14 is class compliant =
in as far as it is recognised and some audio can be heard. Unfortunately th=
at is as far as it goes (currently) as there is no mixer available to ALSA =
or Pulse etc. If you open a terminal and run alsamixer, press F6 and select=
 Audient iD14, it will report a broken pipe error. ALSA (or Pulseaudio) has=
 no way of knowing how to allocate the outputs, so assumes all 4 detected o=
uts are available, but also has no way of directing signal appropriately.&q=
uot;</i></div><div><br></div><div>I would like to ask your help to establis=
h what the best course of action would be.</div><div><br></div><div>Should =
I work on trying to fix this issue with a custom <a href=3D"http://www.alsa=
-project.org/main/index.php/Asoundrc">.asoundrc</a> file, possibly using th=
e <a href=3D"http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html=
#pcm_plugins_multi">multi plugin</a>?</div><div><br></div><div>If that&#39;=
s not possible, what would writing a ALSA USB driver specifically for the A=
udient iD14 entail?=C2=A0</div><div><br></div><div><a href=3D"https://audie=
nt.com/products/audio-interfaces/id14/downloads/">iD14 manual and specifica=
tions</a></div><div><br></div><div>I would appreciate your thoughts and ins=
ights on this.=C2=A0</div><div><br></div><div>Kind regards,</div><div>Charl=
es Mulder</div><div><br></div></div><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr">Charles Mulder<div>Software Engineer/Musician<div><div>mobile: =
+27 83 653 3698</div><div>phone: +27 27 948 2592</div><div>skype: charliemu=
rder</div></div></div></div></div>

--001a113f810230bffb05636c286a--


--===============6104762870893253040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============6104762870893253040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============6104762870893253040==--
