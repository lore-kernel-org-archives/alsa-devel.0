From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [LAU] Terratec EWS88D (ice1712) optical stuck on ADAT (no IEC958
	optical i/o)
Date: Mon, 13 Sep 2010 08:55:48 -0700
Message-ID: <AANLkTik7=sY9VJ2QX9j=W4+qH5s6SfBKi-LGG2WeF3x1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3459862315705793277=="
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-audio-user <linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============3459862315705793277==
Content-Type: multipart/alternative; boundary=90e6ba53a6524457eb04902621b0

--90e6ba53a6524457eb04902621b0
Content-Type: text/plain; charset=UTF-8

I just scored a nice Terratec EWS88D for $20.00. :-)  (
http://nielsmayer.com/envy24control/EWS88D_Board_L.jpg missing midi cable
though (*))
It works nicely with Linux and http://mudita24.googlecode.com ,  although
it's missing some important controls to turn off the ADAT parts of the card.
Alas, it wouldn't help to support them in mudita24, as I cannot get them to
change values through standard ALSA tools like amixer(1) and alsamixer(1).

Therefore, the question: is what is it about snd-ice1712 that prevents the
mixer control values detailed below from changing, and is there anything I
can do to fix it? (sometimes you want to use this card in it's dual IEC958
optical + spdif I/O config, other times, you want to use the optical for
ADAT and the spdif for IEC958, which is the only configuration I can get
currently.)

The results from amixer(1):
  http://nielsmayer.com/envy24control/terratec-ews88d-amixer.txt
Results of "cat /proc/asound/EWS88D/ice1712":
  http://nielsmayer.com/envy24control/terratec-ews88d-ice1712.txt

My attempts at changing optical port from ADAT to IEC958. Nothing happens:

///// ///// ///// ///// ///// ///// ///// /////
coggie-7-~>  foreach i ( 'IEC958 Input Optical' 'IEC958 Input Optical' 'ADAT
External Master Clock' 'ADAT Output Optical' 'ADAT Through' 'Enable ADAT' )
foreach? amixer cget iface=MIXER,name="$i"
foreach? end
numid=95,iface=MIXER,name='IEC958 Input Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=95,iface=MIXER,name='IEC958 Input Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=97,iface=MIXER,name='ADAT External Master Clock'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=96,iface=MIXER,name='ADAT Output Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=99,iface=MIXER,name='ADAT Through'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=98,iface=MIXER,name='Enable ADAT'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
coggie-10-~> amixer cset iface=MIXER,name='Enable ADAT' off
numid=98,iface=MIXER,name='Enable ADAT'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
coggie-11-~> amixer cset iface=MIXER,name='Enable ADAT' false
numid=98,iface=MIXER,name='Enable ADAT'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
coggie-12-~> amixer cset iface=MIXER,name='Enable ADAT' off
numid=98,iface=MIXER,name='Enable ADAT'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
coggie-13-~> amixer cset iface=MIXER,name='Enable ADAT' 0
numid=98,iface=MIXER,name='Enable ADAT'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
coggie-14-~> amixer cset iface=MIXER,name='IEC958 Input Optical' on
numid=95,iface=MIXER,name='IEC958 Input Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
coggie-15-~> amixer cset iface=MIXER,name='IEC958 Input Optical' true
numid=95,iface=MIXER,name='IEC958 Input Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
coggie-16-~> amixer cset iface=MIXER,name='IEC958 Input Optical' 1
numid=95,iface=MIXER,name='IEC958 Input Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
///// ///// ///// ///// ///// ///// ///// /////

FYI, for more info on this board:
  ftp://ftp.terratec.de/Audio/EWS/88D/Manual/EWS88D_Manual_GB.pdf
  ftp://ftp.terratec.de/Audio/EWS/88D/TechnicalData/EWS88D_GB.pdf

Relevant snd-ice1712 sources:

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=sound/pci/ice1712/ews.c;hb=HEAD

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=sound/pci/ice1712/ice1712.c;hb=HEAD

Also, I'm running on Fedora12 ( 2.6.32.21-166.fc12.x86_64 ) which seems to
have a somewhat odd mix of ALSA drivers and runtime:

coggie-17-~> drumstick-sysinfo
ALSA Sequencer System Info, version: 0.5.0
Compiled ALSA library: 1.0.23
Runtime ALSA library: 1.0.23
Runtime ALSA drivers: 1.0.21.
Numeric ALSA compiled library: 10017
Numeric ALSA runtime library: 10017
Numeric ALSA runtime driver: 10015

Will Fedora13 or "runtime ALSA drivers: 1.0.23" remedy this situation?
(Probably not EWS88D is a pretty old card and I don't see any changes
related to it recently). The target machine for this card will actually be
running Fedora13, however, that machine hasn't been decommissioned, wiped,
or setup for that purpose yet....

Niels
http://nielsmayer.com

PS: (*) Anybody know where to find/build a 9-pin MIDI cable for the EWS88D?
Will the RME HDSP9652 cable fit/work?
http://www.bananasmusic.com/productdetail.asp/pid_3970/productname_RME-BOHDSP9652MIDI-MIDI-Breakout-Cable

--90e6ba53a6524457eb04902621b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>I just scored a nice Terratec EWS88D=C2=A0for $20.00. :-) =C2=A0(=C2=
=A0<a href=3D"http://nielsmayer.com/envy24control/EWS88D_Board_L.jpg">http:=
//nielsmayer.com/envy24control/EWS88D_Board_L.jpg</a>=C2=A0missing midi cab=
le though (*))</div><div>
It works nicely with Linux and <a href=3D"http://mudita24.googlecode.com">h=
ttp://mudita24.googlecode.com</a> , =C2=A0although it&#39;s missing some im=
portant controls to turn off the ADAT parts of the card. Alas, it wouldn&#3=
9;t help to support them in mudita24, as I cannot get them to change values=
 through standard ALSA tools like amixer(1) and alsamixer(1).</div>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><d=
iv><br></div><div>Therefore, the question: is what is it about snd-ice1712 =
that prevents the mixer control values detailed below from changing, and is=
 there anything I can do to fix it? (sometimes you want to use this card in=
 it&#39;s dual IEC958 optical + spdif I/O config, other times, you want to =
use the optical for ADAT and the spdif for IEC958, which is the only config=
uration I can get currently.)</div>
<div><br></div><div>The results from amixer(1):=C2=A0</div><div>=C2=A0=C2=
=A0<a href=3D"http://nielsmayer.com/envy24control/terratec-ews88d-amixer.tx=
t">http://nielsmayer.com/envy24control/terratec-ews88d-amixer.txt</a></div>=
<div>Results of &quot;cat /proc/asound/EWS88D/ice1712&quot;:=C2=A0</div>
<div>=C2=A0=C2=A0<a href=3D"http://nielsmayer.com/envy24control/terratec-ew=
s88d-ice1712.txt">http://nielsmayer.com/envy24control/terratec-ews88d-ice17=
12.txt</a></div><div><br></div><div>My attempts at changing optical port fr=
om ADAT to IEC958. Nothing happens: =C2=A0</div>
<div><br></div><meta http-equiv=3D"content-type" content=3D"text/html; char=
set=3Dutf-8"><div><div>///// ///// ///// ///// ///// ///// ///// /////</div=
></div><div>coggie-7-~&gt; =C2=A0foreach i ( &#39;IEC958 Input Optical&#39;=
 &#39;IEC958 Input Optical&#39; &#39;ADAT External Master Clock&#39; &#39;A=
DAT Output Optical&#39; &#39;ADAT Through&#39; &#39;Enable ADAT&#39; )</div=
>
<div><div>foreach? amixer cget iface=3DMIXER,name=3D&quot;$i&quot;</div><di=
v>foreach? end</div><div>numid=3D95,iface=3DMIXER,name=3D&#39;IEC958 Input =
Optical&#39;</div><div>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,value=
s=3D1</div><div>=C2=A0=C2=A0: values=3Doff</div>
<div>numid=3D95,iface=3DMIXER,name=3D&#39;IEC958 Input Optical&#39;</div><d=
iv>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=C2=
=A0=C2=A0: values=3Doff</div><div>numid=3D97,iface=3DMIXER,name=3D&#39;ADAT=
 External Master Clock&#39;</div><div>
=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=C2=A0=
=C2=A0: values=3Don</div><div>numid=3D96,iface=3DMIXER,name=3D&#39;ADAT Out=
put Optical&#39;</div><div>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,v=
alues=3D1</div><div>=C2=A0=C2=A0: values=3Don</div><div>numid=3D99,iface=3D=
MIXER,name=3D&#39;ADAT Through&#39;</div>
<div>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=
=C2=A0=C2=A0: values=3Doff</div><div>numid=3D98,iface=3DMIXER,name=3D&#39;E=
nable ADAT&#39;</div><div>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,va=
lues=3D1</div><div>=C2=A0=C2=A0: values=3Don</div><div>coggie-10-~&gt; amix=
er cset iface=3DMIXER,name=3D&#39;Enable ADAT&#39; off</div>
<div>numid=3D98,iface=3DMIXER,name=3D&#39;Enable ADAT&#39;</div><div>=C2=A0=
=C2=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=C2=A0=C2=A0:=
 values=3Don</div><div>coggie-11-~&gt; amixer cset iface=3DMIXER,name=3D&#3=
9;Enable ADAT&#39; false</div><div>
numid=3D98,iface=3DMIXER,name=3D&#39;Enable ADAT&#39;</div><div>=C2=A0=C2=
=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=C2=A0=C2=A0: va=
lues=3Don</div><div>coggie-12-~&gt; amixer cset iface=3DMIXER,name=3D&#39;E=
nable ADAT&#39; off</div><div>numid=3D98,iface=3DMIXER,name=3D&#39;Enable A=
DAT&#39;</div>
<div>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=
=C2=A0=C2=A0: values=3Don</div><div>coggie-13-~&gt; amixer cset iface=3DMIX=
ER,name=3D&#39;Enable ADAT&#39; 0</div><div>numid=3D98,iface=3DMIXER,name=
=3D&#39;Enable ADAT&#39;</div><div>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw=
------,values=3D1</div>
<div>=C2=A0=C2=A0: values=3Don</div><div>coggie-14-~&gt; amixer cset iface=
=3DMIXER,name=3D&#39;IEC958 Input Optical&#39; on</div><div>numid=3D95,ifac=
e=3DMIXER,name=3D&#39;IEC958 Input Optical&#39;</div><div>=C2=A0=C2=A0; typ=
e=3DBOOLEAN,access=3Drw------,values=3D1</div>
<div>=C2=A0=C2=A0: values=3Doff</div><div>coggie-15-~&gt; amixer cset iface=
=3DMIXER,name=3D&#39;IEC958 Input Optical&#39; true</div><div>numid=3D95,if=
ace=3DMIXER,name=3D&#39;IEC958 Input Optical&#39;</div><div>=C2=A0=C2=A0; t=
ype=3DBOOLEAN,access=3Drw------,values=3D1</div>
<div>=C2=A0=C2=A0: values=3Doff</div><div>coggie-16-~&gt; amixer cset iface=
=3DMIXER,name=3D&#39;IEC958 Input Optical&#39; 1</div><div>numid=3D95,iface=
=3DMIXER,name=3D&#39;IEC958 Input Optical&#39;</div><div>=C2=A0=C2=A0; type=
=3DBOOLEAN,access=3Drw------,values=3D1</div>
<div>=C2=A0=C2=A0: values=3Doff</div></div><div>///// ///// ///// ///// ///=
// ///// ///// /////</div><div><br></div><div><div>FYI, for more info on th=
is board:</div><div>=C2=A0=C2=A0<a href=3D"ftp://ftp.terratec.de/Audio/EWS/=
88D/Manual/EWS88D_Manual_GB.pdf">ftp://ftp.terratec.de/Audio/EWS/88D/Manual=
/EWS88D_Manual_GB.pdf</a></div>
<div>=C2=A0=C2=A0<a href=3D"ftp://ftp.terratec.de/Audio/EWS/88D/TechnicalDa=
ta/EWS88D_GB.pdf">ftp://ftp.terratec.de/Audio/EWS/88D/TechnicalData/EWS88D_=
GB.pdf</a></div></div><div><br></div><div>Relevant snd-ice1712 sources:</di=
v><div>=C2=A0=C2=A0<a href=3D"http://git.alsa-project.org/?p=3Dalsa-kernel.=
git;a=3Dblob_plain;f=3Dsound/pci/ice1712/ews.c;hb=3DHEAD">http://git.alsa-p=
roject.org/?p=3Dalsa-kernel.git;a=3Dblob_plain;f=3Dsound/pci/ice1712/ews.c;=
hb=3DHEAD</a></div>
<div>=C2=A0=C2=A0<a href=3D"http://git.alsa-project.org/?p=3Dalsa-kernel.gi=
t;a=3Dblob_plain;f=3Dsound/pci/ice1712/ice1712.c;hb=3DHEAD">http://git.alsa=
-project.org/?p=3Dalsa-kernel.git;a=3Dblob_plain;f=3Dsound/pci/ice1712/ice1=
712.c;hb=3DHEAD</a></div>
<div><br></div><div>Also, I&#39;m running on Fedora12 ( 2.6.32.21-166.fc12.=
x86_64 ) which seems to have a somewhat odd mix of ALSA drivers and runtime=
:</div><div><br></div><div><div>coggie-17-~&gt; drumstick-sysinfo=C2=A0</di=
v>
<div>ALSA Sequencer System Info, version: 0.5.0</div><div>Compiled ALSA lib=
rary: 1.0.23</div><div>Runtime ALSA library: 1.0.23</div><div>Runtime ALSA =
drivers: 1.0.21.</div><div>Numeric ALSA compiled library: 10017</div><div>
Numeric ALSA runtime library: 10017</div><div>Numeric ALSA runtime driver: =
10015</div></div><div><br></div><div>Will Fedora13 or &quot;runtime ALSA dr=
ivers: 1.0.23&quot; remedy this situation? (Probably not EWS88D is a pretty=
 old card and I don&#39;t see any changes related to it recently). The targ=
et machine for this card will actually be running Fedora13, however, that m=
achine hasn&#39;t been=C2=A0decommissioned, wiped, or setup for that purpos=
e yet....</div>
<div><br></div>Niels<br><a href=3D"http://nielsmayer.com">http://nielsmayer=
.com</a><br><div><br></div><div>PS: (*) Anybody know where to find/build a =
9-pin MIDI cable for the EWS88D? Will the RME HDSP9652 cable fit/work?</div=
>
<div><a href=3D"http://www.bananasmusic.com/productdetail.asp/pid_3970/prod=
uctname_RME-BOHDSP9652MIDI-MIDI-Breakout-Cable">http://www.bananasmusic.com=
/productdetail.asp/pid_3970/productname_RME-BOHDSP9652MIDI-MIDI-Breakout-Ca=
ble</a></div>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8">

--90e6ba53a6524457eb04902621b0--

--===============3459862315705793277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-audio-user mailing list
Linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
http://lists.linuxaudio.org/listinfo/linux-audio-user

--===============3459862315705793277==--
