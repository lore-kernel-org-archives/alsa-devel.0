From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 14:05:23 +0100
Message-ID: <200601091405.23939.rene__49511.2940473065$1136812054$gmane$org@exactcode.de>
References: <20050726150837.GT3160@stusta.de> <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi> <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx02.qsc.de (mx02.qsc.de [213.148.130.14])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 850CC141
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 14:06:03 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Hannu Savolainen <hannu@opensound.com>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sunday 08 January 2006 10:24, Jaroslav Kysela wrote:

> > > > > - PCM with non-interleaved formats
> > > > There is no need to handle non-interleaved data in kernel level drivers 
> > > > because all the devices use interleaved formats.
> > > 
> > > Many RME boards support only non-intereleave data.
> > In such cases it's better to do interleavin/deinterleaving in the kernel 
> > rather than forcing the apps to check which method they should use.
> 
> I don't think so. The library can do such conversions (and alsa-lib does) 
> quite easy. If we have a possibility to remove the code from the kernel 
> space without any drawbacks, then it should be removed. I don't see any 
> advantage to have such conversions in the kernel.

Also, when the data is already available as single streams in a user-space
multi track application, why should it be forced interleaved, when the hardware
could handle the format just fine?

Yours,
  Rene

-- 
ExactCODE, Berlin


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
