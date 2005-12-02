From: "Ken Smith" <kens@kensnet.org>
Subject: Flame Risk FM801 Problem
Date: Fri, 2 Dec 2005 10:07:17 -0000
Message-ID: <000201c5f728$2cdcd670$190010ac@kensmw2kp>
Reply-To: <kens@kensnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Apologies in advance I know this is a dev list - if you have any ideas =
on
this I'd be very grateful...

I have a problem with an FM801 on an FC3 system. It won't play any sound
files. The driver is loaded and all the faders are maxed out in =
alsamixer. I
can hear a slight 'tick' in the speakers when I mute and unmute the mic
channel. The FM801 driver has been around a while so I guess is fairly
mature. The system is an upgrade from FC1 so has gone 2.4 to 2.6.12. The
FM801 didn't work in FC1 either.

Has anyone got any ideas who could help. I tried the alsa-users &
linux-audio lists - no replies. I must have missed something... Is there =
a
test program that I could use to hose sound data at the driver to test =
it?
Or is there a test program that can drive the card directly to prove =
whether
it works. Audacity hangs playing a .wav file. lspci & lsmod look right. =
The
speakers work. Nothing is holding on to /dev/dsp. {is that the right
device?} It=92s the only sound device in the system. The card has been =
swapped
out, I'm tempted to try an alternative make of card but I suspect that's =
not
the problem. alsa is at 1.0.9 but the alsa firmware is 1.0.8 both are =
the
ccrma FC3 APT build. Is that significant?


Any help or pointers most welcome...

Thanks in advance
=A0
Ken


--=20
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.362 / Virus Database: 267.13.10/190 - Release Date: =
01/12/2005
=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
