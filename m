From: Shaju Abraham <shaju@multitech.co.in>
Subject: Use only a few bds.
Date: Thu, 22 Aug 2002 10:15:13 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D646C59.22B1BBBB@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id GAA10660
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 06:47:52 +0200
Received: from multitech.co.in (atmesh [192.168.1.46])
	by multitech.co.in (8.12.1/8.12.1) with ESMTP id g7M4mvUZ001747
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 10:18:57 +0530
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

    In our study that we are doing abt latency of sound cards, we want
to have a situation where I do not want to use all of the 32 bds
available. we want to use say only 4 or 8 of the bds with each bd
pointing to only a small fragment of data.( This is basically to make
the card interrupt frequently and will also should not be able to
proceed if the interrupts raised by the past bds have not been serviced.
So want to restrict it to 4 or 8 ) .

It will be of great help if you can help us on the following two points.

            i)  What is the significance of ICH_MAX_FRAGS?  ( It seems
to be used only for the allocation of pages for the buffer and for
little else during the actual functioning of the card.)

            ii)    What is the significance of ICH_REG_LVI_MASK?  (This
is more used during the actual functioning of the card & is used in the
interrupt service sub-routine to update the lvi.)  It is by default 0x1f
. Is this 'cos it can be used to address the 32 bds available.  I
changed this to 3 and 7 . I observed that this makes the card to use
only 4 or 8 of the bds available. Am I correct in this conclusion?  If I
do this, I get some noise. Is this because of the interrupts raised by
the unused bds?

    If I am wrong abt all this, how should I go abt my idea of using
only 4 or 8 of the bds available?

Thanx,
--Shaju




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
