From: Arnaud Patard <apatard@mandriva.com>
Subject: HDA pin sense and presence detect capability
Date: Wed, 25 Jan 2006 16:34:22 +0100
Message-ID: <m3k6copbi9.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D3C7218F
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 16:32:33 +0100 (MET)
Received: from anduin.mandrakesoft.com (anduin.mandrakesoft.com [192.168.100.45])
	by office.mandriva.com (Postfix) with ESMTP id 4976153EB7
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 16:32:33 +0100 (CET)
Received: from anduin.mandrakesoft.com (localhost [127.0.0.1])
	by anduin.mandrakesoft.com (Postfix) with ESMTP id BE4CFFF855
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 16:34:22 +0100 (CET)
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


On some laptops with HDA codecs, there are different nids for the
Headphones and for the built-in speakers. This results in having sound
on speakers and on headphones at the same time. imho, the expected
behaviour is to have sound only on headphones (without having to play
with the mixer).

This can be achieve with the presence detect capability (0x709,0xf09): When
plug/unplugging the headphones, one gets an unsollicited responsed and
the driver mute the channels.

Is there something to do that in the code or should I go and code it ?
Any opinion/comments about that ?


Regards,
Arnaud



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
