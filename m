From: Lee Revell <rlrevell@joe-job.com>
Subject: cannot set capture period below 512 on SBLive
Date: Tue, 08 Jun 2004 14:38:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1086719918.6932.9.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hey,

I originally asked this on linux-audio-dev, and was referred here:

> It seems to be a known issue that you cannot run JACK with the capture
> period size lower than 512 with the SBLive ALSA driver.

I did some more research and found this thread that seems to indicate
this (or a similar) problem was fixed in CVS a few months ago:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg12181.html

Am I correct in that this should let me actually get low latency
operation using JACK with this card?  Jaroslav's comment just says
'fixed in CVS', and I didn't see a specific reference to this in the
changelog, was this an emu10k1 issue or an ALSA midlevel issue?

Thanks,

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
