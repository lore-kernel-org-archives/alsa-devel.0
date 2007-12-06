From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi driver -> kernel
Date: Fri, 07 Dec 2007 12:33:23 +1300
Message-ID: <475886C3.9070301@audioscience.com>
References: <200709051300.35503.linux@audioscience.com>
	<s5hzm01tn8w.wl%tiwai@suse.de> <47141823.4000307@audioscience.com>
	<s5hbqaqrppa.wl%tiwai@suse.de> <47397615.4000201@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id E28BD243ED
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 00:33:31 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JSN0084YIROUM30@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 07 Dec 2007 12:33:27 +1300 (NZDT)
In-reply-to: <47397615.4000201@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> Working on it, will submit new patches in the next week or so.

Hi Takashi,

I have been beating our code with a big stick for the last 4 weeks.

I'd appreciate any comment you have on the progress.



You can see the result here:
http://audioscience.com/internet/download/beta/alsahg3459_asihpi30905.tar.gz

The matching firmware is here:
http://audioscience.com/internet/download/beta/dspbins30905.tar.bz2

Note that dsp6413.bin is replaced by dsp6400.bin, dsp8713 by dsp8700.
You can remove all the dsp*.txt from the repo they are not needed.  Also
remove dsp2400, its not relevant.


The code is copmplete files rather than diffs, there are so many diffs I
don't think it is useful.  Apart from cosmetic changes, there are some
added and removed files compared to curren ALSA Hg repo:

* Merged all files relating to HPI4000 into hpi4000.[ch] (remove
hpi56301.[ch], boot4ka.h, dpi56301.h
* Removed hpicheck.h
* add hpimsginit.[ch] (no new functions)


Cosmetic changes
* Code is mostly 'checkpatch clean', though still some real work to do
around our use of volatile for structures that are updated by DMA by our
adapters

* Only 2 'sparse' warnings

* Got rid of nearly all typedefs, and most thin wrappers around kernel
functions.

* hpifunc.c now has no comments.  They might return when we get around
to grinding them all down to 80 columns...
Extracted documentation is available here in the mean time:
http://audioscience.com/internet/download/sdk/hpi_usermanual_html/html/index.html

regards

Eliot Blennerhassett
AudioScience Inc.
