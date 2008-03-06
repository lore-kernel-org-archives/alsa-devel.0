From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH 3/5] asihpi: Remove HPI4000
Date: Fri, 07 Mar 2008 12:32:52 +1300
Message-ID: <200803071232.52272.linux@audioscience.com>
References: <200803061449.18512.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id A94AD1038FD
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 00:29:49 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXC001YL19M6K10@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 07 Mar 2008 12:29:47 +1300 (NZDT)
In-reply-to: <200803061449.18512.linux@audioscience.com>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thursday 06 March 2008 14:49:18 Eliot Blennerhassett wrote:
> Remove HPI4000

This also requires update to alsa-firmware/asihpi with files from 
http://audioscience.com/internet/download/firmware/dspbins30914.tar.gz

dsp4*.bin are no longer required.

Also alsa-driver/pci/asihpi/hpi4000.* are no longer required.
AudioScience next stable driver release (3.10.0) will not include support for 
ASI4xxx cards.

AudioScience will continue to maintain our version 3.08.xx with bugfixes for 
these cards and  ALSA 1.0.16 will be the last alsa release with support for 
ASI4xxx.

We are dropping support for the family because the cards are not in production 
any more, and we wont be adding new API support to the DSP code that will be 
required by new drivers.

regards

Eliot Blennerhassett
AudioScience.
