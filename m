From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 18:12:55 +0100
Message-ID: <200601091812.55943.rene__27820.0768902481$1138785885$gmane$org@exactcode.de>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de> <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7BDE9140
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 18:16:24 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Monday 09 January 2006 16:10, Hannu Savolainen wrote:

> > > I don't think so. The library can do such conversions (and alsa-lib does) 
> > > quite easy. If we have a possibility to remove the code from the kernel 
> > > space without any drawbacks, then it should be removed. I don't see any 
> > > advantage to have such conversions in the kernel.
> > 
> > Also, when the data is already available as single streams in a user-space
> > multi track application, why should it be forced interleaved, when the hardware
> > could handle the format just fine?
> Because the conversion doesn't cost anything. Trying to avoid it by 
> making the API more complicated (I would even say confusing) is extreme 
> overkill. 

Since when doesn't cost convesion anything? I'm able to count a lot of wasted
CPU cycles in there ...

> Even worse this kind of features weaken the device abstraction provided by 
> the API. The applications will have to check for this and 
> that and provide support for 100s of special cases that may be required by 
> certain devices. 

An lame write() only player can still open the default device and get the auto-convert
chain it deserves ...

Yours,
  Rene Rebe

-- 
ExactCODE Berlin


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
