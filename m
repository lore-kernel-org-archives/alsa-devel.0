From: "Jack O'Quin" <joq@io.com>
Subject: CVS commit [0.99.11] ALSA playback latency patch
Date: 17 Nov 2004 23:04:39 -0600
Message-ID: <878y8zvjbs.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: jackit-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


  * applied Takashi's ALSA driver patch (thanks!)

  * --nperiods now sets playback latency, not buffer size

  * man page update...

       -n, --nperiods int
              Specify  the number of periods of playback latency.
              In seconds, this corresponds  to  --nperiods  times
              --period  divided by --rate.  The default is 2, the
              minimum allowable.  For most devices, there  is  no
              need  for  any  other  value  with  the  --realtime
              option.  Without realtime privileges or with boards
              providing  unreliable  interrupts  (like ymfpci), a
              larger value may yield fewer xruns.  This can  also
              help  if the system is not tuned for reliable real=AD
              time scheduling.

              For most ALSA  devices,  the  hardware  buffer  has
              exactly  --period  times  --nperiods  frames.  Some
              devices demand a larger buffer.  If so,  JACK  will
              use  the  smallest  possible  buffer  containing at
              least --nperiods, but the playback latency does not
              increase.

Would someone with an RME32/96 card please test this version and
report your results.  You should now be able to run with --nperiods=3D2,
which did not work before due to the card's fixed buffer size (IIUC).
--=20
  joq


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
