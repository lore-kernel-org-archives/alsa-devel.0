From: <jfm3@ouroboros-complex.org>
Subject: multiple instances of snd-virmidi?
Date: Tue, 3 Jun 2003 18:05:09 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41797.24.225.156.130.1054688709.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Is there some way I can load snd-virmidi into the kernel multiple times?

This would help me get around a deficiency in Pd. Pd uses OSS to open the
MIDI devices, and only opens each one once. So it only talks to port 1 on
my mtpav, for example. It treats a virmidi device the same way. But I
figure if I could load multiple virmidi drivers I could hack around this.
Sad but true.

(jfm3)




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
