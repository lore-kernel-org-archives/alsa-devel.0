From: "David Shust" <dshust@bemail.org>
Subject: Patch: YMF753 for rc5
Date: Sun, 10 Nov 2002 02:32:11 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211101032.gAAAWBT30515@mail8.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

My latest Yamaha YMF753 patch for alsa-driver-0.9.0rc5 is available at www.shustring.com.

Module parameters are no longer used.

RC5 has fixed the annoying delay where the first bit of audio would not play via S/PDIF output. This has obviated the need for the delay I'd coded in my previous patch.

Mixer controls added:
S/PDIF output pin
S/PDIF mute
S/PDIF output source: digital link or A/D converter
speaker size
wide mode stereo
tone controls (do not conform to AC'97 standard)

In order to have CD output through the S/PDIF connector on my Toshiba Satellite 5000, I have to set the CD as recording source and set S/PDIF output to A/D converter.

In order to have output via S/PDIF on the Toshiba Satellite 5000, the S/PDIF output pin must be set to 43.

David Shust

------------------------------------------------------------
Free, BeOS-friendly email accounts: http://BeMail.org/
BeOS News and Community: http://www.BeGroovy.com/


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
