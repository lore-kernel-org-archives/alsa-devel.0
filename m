From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 15:42:41 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306121542.41261.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Encouraged by Jesse's recent success I tried again,
now with firmware rev 10. The module loads,
firmware is loaded but with
Hwdep ioctl error on card hw:0 : Input/output error.

Still, to my disappointment,
aplay -D hw:0,0 fails with
aplay: set_params:800: Access type not available
If the error checking for access type is commented out,
aplay fails on not being able to determine the sample format
(the next error check in aplay.c)
Why is this information not available?
Any ideas?

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
