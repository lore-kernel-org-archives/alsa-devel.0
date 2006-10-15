From: Elie Morisse <lachienne@wanadoo.fr>
Subject: LADSPA endeavour : Unable to load plugin
Date: Sun, 15 Oct 2006 11:41:40 +0400
Message-ID: <1160898100l.20828l.0l@zerox>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi people,

I'm attempting to setup an equalizer at ALSA level, and the tap_eq LADSPA p=
lugin seems to be the right way to do this. However I found only very few d=
ocumentation on LADSPA plugins usage in ALSA.. it was still enough to fill =
my asound.conf file :

######
defaults.pcm.rate_converter "samplerate"

pcm.hd595_ladspa {
    type ladspa
    slave.pcm "plughw:0,0";
    playback_plugins [ {
        id 2141
        label tap_eq
        filename "/usr/lib/ladspa/tap_eq.so"
        input {
            controls [ 60 -4.5
                       170 0
                       310 -4.5
                       600 -11
                       1000 -8.5
                       3000 -13
                       12000 -15
                       14000 -8.2 ]
        }
    } ]
}

pcm.hd595 {
    type plug
    slave.pcm "hd595_ladspa";
}
######

thought it doesn't work for now. Here's the aplay output :

$ aplay -Dhd595 test.wav
ALSA lib pcm_ladspa.c:1481:(snd_pcm_ladspa_add_plugin) Unable to load plugi=
n 'tap_eq' ID 2141, filename '/usr/lib/ladspa/tap_eq.so'
aplay: main:550: audio open error: Aucun fichier ou r=E9pertoire de ce type

/usr/lib/ladspa/tap_eq.so is present, also commenting some of the id/label/=
filename lines doesn't help either. .
Something wrong with my config ? ( ALSA 1.0.13 drivers and lib )

Cheers! =


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
