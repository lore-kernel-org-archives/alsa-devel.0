From: gwatson@linuxlogin.com
Subject: alsa-0.9.3c + Audigy2
Date: Thu, 29 May 2003 21:12:58 -0600 (MDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33144.65.103.115.186.1054264378.squirrel@www.linuxlogin.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm having some issues with a Audigy2 using 0.9.3c.

OSS Compat doesn't seem to work at all, but alsa apps seem ok.  (XMMS for
example works with alsa pluigin, but not oss)

I'm trying to get Enemy Territory to work but all it says is:

------- sound initialization -------
Sorry but your soundcard can't do this
------------------------------------


Also 'play' part of the sox package gives me this:
sox: Unable to set audio speed to 22050 (set to 32000)

And no output.  Furthermore, when I try to run a OSS mixer I only see
three lines.  (Line1, Line2, Line3).  Alsamixer shows the right number of
channels.

I'm using OSS-Compat 0.9.1 on 2.4.20-gentoo-r5 with alsa-driver 0.9.3c.

Any suggestions?

Thanks




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
