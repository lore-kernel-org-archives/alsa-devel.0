From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: hdsp I/O-error
Date: Sat, 12 Apr 2003 12:40:17 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304121240.17736.Jaakko.Prattala@Helsinki.FI>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI> <1050086275.1337.37.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050086275.1337.37.camel@satellite.undata.org>
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

On Friday 11 April 2003 21:37, Thomas Charbonnel wrote:
> Could you please send the output of dmesg ?
> Did alsactl tried to restore old settings ?
>
> Thomas

Hi. More info. This is the /var/log/messages output when I run hdsploader=
=2E

Apr 12 12:30:56 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:4104: card initialization pending =
:=20
waiting for firmware
Apr 12 12:31:03 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <=3D 0 f=
ailed=20
after 30 iterations
Apr 12 12:31:03 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:3800: initializing firmware upload
Apr 12 12:31:03 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:522: loading firmware
Apr 12 12:31:03 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:548: finished firmware loading
Apr 12 12:31:07 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <=3D 127=
 failed=20
after 5000 iterations
Apr 12 12:31:07 kiertotahti kernel: ALSA=20
=2E./../alsa-kernel/pci/rme9652/hdsp.c:3824: error creating alsa devices

(I/O-box shows host error).

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
