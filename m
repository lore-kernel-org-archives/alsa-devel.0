From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: rev 10 fw, hdsp I/O-error, more information
Date: Thu, 17 Apr 2003 11:53:11 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304171153.11529.Jaakko.Prattala@Helsinki.FI>
References: <1050314137.1382.23.camel@satellite.undata.org> <200304171051.45549.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304171051.45549.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

If the firmware is loaded (in linux) before modprobing snd-hdsp,
the entries in /dev/snd are created correctly. dmesg has this:
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4111: Firmware already loaded,=20
initializing card.
Still /dev/snd/pcmC0D0p is reported busy and can't be opened
also the modules are busy and can't be removed.

So this looks quite the same as with rev 11 fw except that
the error led is gone and firmware is uploaded

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
