From: G Bouzas <gbouzas@ya.com>
Subject: Configure devices
Date: Sun, 12 Feb 2006 17:17:34 +0100
Message-ID: <1139761055.4779.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpauth.ya.com (smtp06.ya.com [62.151.11.163])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C97181AE
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 17:17:43 +0100 (MET)
Received: from [83.52.245.179] (helo=[192.168.2.3])
	by smtpauth.ya.com with asmtp id 1F8Juq-00074W-00
	for alsa-devel@alsa-project.org; Sun, 12 Feb 2006 17:17:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a recording problem with via82xx.
After a lot investigation, I was able, to record audio by using
'arecord' command on device 1 of card 0.
The command was:

$ arecord -f dat  -D hw:0,1 test.wav

But, still I do not know how to make this device as default, so other
standard apps can use it.

I cannot see in the docs how to make it. Is it in the asoundrc. Its how-
to make only bits of explanation.
Can you help me out?

Germ=C3=A1n Bouzas.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
