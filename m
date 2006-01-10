From: David Lang <dlang@digitalinsight.com>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 16:29:45 -0800 (PST)
Message-ID: <Pine.LNX.4.62.0601091628340.4005__19196.3293277242$1136853310$gmane$org@qynat.qvtvafvgr.pbz>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
 <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.62.0601091515570.4005@qynat.qvtvafvgr.pbz>
 <20060110001617.GA5154@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from warden.diginsite.com (warden-p.diginsite.com [208.29.163.248])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6359512C
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 01:34:08 +0100 (MET)
In-Reply-To: <20060110001617.GA5154@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jan 2006, John Rigg wrote:

>> does the CPU touch the data for these, or do you DMA directly from
>> userspace (i.e. "zero-copy")?
>
> The cards I mentioned use DMA. RME actually advertises that some of their
> cards can handle 52 channels with zero CPU load. Their onboard DSPs can
> also do routing and mixing, again without touching the CPU.

I was under the (apparently mistaken) impression that you couldn't DMA 
from userspace (something to do with the possibility that the userspace 
memory pages could be swapped out in the middle of the DMA)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
