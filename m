From: "Leandro Dardini" <ldardini@tiscali.it>
Subject: vt82xx capture problems, versions tested 0.9.8 and 0.9.1
Date: Sat, 8 Nov 2003 22:19:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02c601c3a63e$0601a4a0$9af21550@athlonpc>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

I recently upgrade from 0.9.1 to 0.9.6 and then to 0.9.8. I have two
motherboard, each using vt82xx driver, but one is
an VIA8235/Avance Logic ALC101 and the other one is a VIA8235/AD1980.

As already reported on the user list (sorry for the mistake), using 0.9.8
with the AD1980, the two channels of Line-in and Aux-in are mixer togheter.
If I choose to capture from the Line-in, then I can hear only one channel,
the other one is captured from Aux, and viceversa. The only stereo input is
so the CD input.

On the ALC101 the results are worst. Using 0.9.8 I can't capture from any
channel. I tried all: Line, Aux and CD and try to hear something from all
three independently from the source selected. Only when I downgrade to 0.9.1
(I reinstall the kernel from scratch and rebuild all) I can capture from
whatever source I want, but only one channel.

I am sure my headset are fully functioning because I test with the direct
output of my tv capturecard and I can hear both channels. I am sure my audio
cable is fully functioning because I switch orientation and I can still
capture the same channel.

Regarding the 0.9.6 I have tested it only with AD1980 and it has the same
problems of the 0.9.8.

I am here to make whatever try you desire.

Leandro



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
