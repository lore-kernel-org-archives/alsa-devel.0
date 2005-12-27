From: Doug McLain <doug@nostar.net>
Subject: Re: [Jackit-devel] Real-world reports on two Delta 1010LTs/ice1712
 synched?
Date: Tue, 27 Dec 2005 00:06:34 -0500
Message-ID: <43B0CBDA.7090000__47508.5686463446$1135660440$gmane$org@nostar.net>
References: <20051223225430.GA4995@localhost.localdomain> <43AC826C.1040405@nostar.net> <20051223233816.GA5102@localhost.localdomain> <43AC8990.7040900@nostar.net> <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dishpan.dreamhost.com (dishpan.dreamhost.com [205.196.218.12])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9EAE2139
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2005 06:06:34 +0100 (MET)
In-Reply-To: <43B0A83F.1040907@nostar.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: John Rigg <j@sound-man.co.uk>, jackit-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Doug McLain wrote:

> All of the envy24control code treats the 1010 and 1010LT equally

...  Except for one crucial line:

hardware.c:165:if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTA1010)

And this is where my problem begins, and yours, well, never starts. :)

I first blindly added ICE1712_SUBDEVICE_DELTA1010LT to the if statement 
hoping for a quick fix, but no luck.  I discovered that the 
snd_ctl_elem_value "Word Clock Status" is only defined for the 1010 and 
not the 1010LT in the ice1712 driver code.

Further digging (starting on line 620 of 
alsa-kernel/pci/ice1712/delta.c) reveals that the 1010 has 2 seperate 
gen purpose i/o registers for the word clock. One appears to be read 
only, for checking status, and the other is the one to set the state. 
The LT has one, that is either meant to serve both checking status and 
setting state, or some driver code is missing.

static snd_kcontrol_new_t snd_ice1712_delta1010_wordclock_select 
__devinitdata =
ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Word Clock Sync", 0, 
ICE1712_DELTA_WORD_CLOCK_SELECT, 1, 0);
static snd_kcontrol_new_t snd_ice1712_delta1010lt_wordclock_select 
__devinitdata =
ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Word Clock Sync", 0, 
ICE1712_DELTA_1010LT_WORDCLOCK, 1, 0);
static snd_kcontrol_new_t snd_ice1712_delta1010_wordclock_status 
__devinitdata =
ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Word Clock Status", 0, 
ICE1712_DELTA_WORD_CLOCK_STATUS, 1, SNDRV_CTL_ELEM_ACCESS_READ | 
SNDRV_CTL_ELEM_ACCESS_VOLATILE);



I'm going to experiment blindly to try to determine the answer to this 
by reading and writing all over the snd_ctl_elem"Word Clock Sync", 
hoping for something good to happen.  If any of the alsa ice1712/delta 
driver gurus are listening, please chime in.

Doug
--
http://nostar.net/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
