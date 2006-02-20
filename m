From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Hidden mixer controls
Date: Mon, 20 Feb 2006 13:00:46 +0000
Message-ID: <1140440446.3733.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orlando.wolfsonmicro.main (webmail.wolfsonmicro.com [212.20.225.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 263091C1
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2006 14:26:37 +0100 (MET)
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
Cc: "Xu, Jingqing" <jingqing.xu@intel.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

Currently mixer controls can be marked inactive (in the driver) with the
SNDRV_CTL_ELEM_ACCESS_INACTIVE flag. This causes alsamixer to skip them
when rendering the mixer controls. 

I'd like to add a similar extension to alsa-lib so that we can
additionally mark controls as hidden within the sound card configuration
file. i.e.

   name "Mic Select"
   preserve true
   value "Mic1"
   lock true
   optional true
   inactive true

The reason for needing this is that the ASoC codec drivers are generic
and must export all the codec controls. This can make alsamixer very big
(and confusing) with a lot of unused controls.

Any objections ?

Liam



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
