From: Shaju Abraham <shaju@multitech.co.in>
Subject: Buffer_size divided into more than 32 frags.
Date: Thu, 22 Aug 2002 10:15:55 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D646C83.95E62185@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id GAA10670
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 06:48:27 +0200
Received: from multitech.co.in (atmesh [192.168.1.46])
	by multitech.co.in (8.12.1/8.12.1) with ESMTP id g7M4ndUZ001779
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 10:19:39 +0530
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

 Can frags may be more than the number of bds available i.e 32 ?  If
yes, does it follow that both of the following cases are possible.


                     i) the whole buffer (of size buffer_size ) can be
divided between 32 bds so that a given bd will always point to same
address during the course of emptying the buffer

                    ii) If I force the fragment size to be small, the
big buffer_size can be get divided into more than 32 frags.  So a given
bd will be pointing to different places in the buffer during the course
of emptying the buffer.

Thanx,
--Shaju




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
