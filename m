From: "Ulrich Zadow" <ulrich.zadow@ARTCOM.DE>
Subject: oss emulation for rme9652
Date: Thu, 28 Feb 2002 13:05:48 +0100
Message-ID: <C1E3CFAE25BBCB45AAB06733BDC048DF18BBC9@tempo.INTERN.ARTCOM.DE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: David Siegel <david.siegel@ARTCOM.DE>
List-Id: alsa-devel@alsa-project.org

Hi,

we're trying to get an rme9652 soundcard to work using the ALSA oss =
emulation layer and we're stuck at a strange place. Any help is =
appreciated. In particular: Can anyone confirm that the oss emulation =
works with the rme? (If not: How hard would it be to reengineer our =
software to use ALSA directly?)

Our software is a mixer we developed inhouse. We've installed ALSA ver =
0.5.12a. Other soundcards (Soundblaster live and viaxxx) work perfectly =
using oss-free drivers. aplay using the rme works too. play using the =
rme doesn't work ("sox: Invalid audio buffer size 0") and in our =
application, the first write() to /dev/dsp returns with an "Invalid =
Argument". This is our code (reduced to the minimum nessesary):

    _myDevice =3D open("/dev/dsp", O_WRONLY, 0);
    if (_myDevice =3D=3D -1) {
        cerr << "failed." << endl;
        perror("/dev/dsp");=20
    }=20
    cerr << "done." << endl;

    short myShortData[BLOCKSIZE];
    memset (myShortData, 0, BLOCKSIZE*2);
    int myRetVal =3D ::write (_myDevice, myShortData, sizeof =
(myShortData));
    if (myRetVal =3D=3D -1) {
        perror (("/dev/dsp");
    }

open() works, write() doesn't. We can set the sample size (via ioctl()) =
without problems, but setting the number of channels again returns with =
"Invalid Argument"...

This is what lsmod tells us:

  snd-pcm-oss            18368   0
  snd-pcm-plugin         14224   0  [snd-pcm-oss]
  snd-mixer-oss           4896   0  [snd-pcm-oss]
  mixer                  17792   0  [snd-mixer-oss]
  snd-mixer              27680   0  [mixer]
  snd-card-rme9652        1472   0
  snd-rme9652            12112   0  [snd-card-rme9652]
  snd-pcm                31968   0  [snd-pcm-oss snd-pcm-plugin =
snd-rme9652]
  snd-timer               9616   0  [snd-pcm]
  snd-rme9652_mem         1472   2  [snd-rme9652]
  snd                    33600   1  [snd-pcm-oss snd-pcm-plugin =
snd-mixer-oss mixer snd-mixer snd-card-rme9652 snd-rme9652 snd-pcm =
snd-timer]
  NVdriver              818016  14  (autoclean)

Again, we're grateful for any help.

Thanks in advance,

  Uli

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
