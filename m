From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA : hda - bug fix on return value check
 when getting supported power states of a codec
Date: Fri, 10 Aug 2012 10:22:25 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F816FE03@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F816FDAD@SHSMSX101.ccr.corp.intel.com>
 <s5ha9y3ys3p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id C456E266429
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 11:52:43 +0200 (CEST)
In-Reply-To: <s5ha9y3ys3p.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Sorry for using HTML format. The patch is resent with new subject:  [PATCH] ALSA : hda - bug fix on checking the supported power states of a codec.
Please review, thanks again!

Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, August 10, 2012 6:11 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org; Wang, Xingchao
> Subject: Re: [PATCH] ALSA : hda - bug fix on return value check when
> getting supported power states of a codec
> 
> At Fri, 10 Aug 2012 09:15:51 +0000,
> Lin, Mengdong wrote:
> >
> > The return value of snd_hda_param_read() is -1 for an error, otherwise
> it's the supported power states of a codec.
> >
> > The supported power states is a 32-bit value. Bit 31 will be set to 1 if the
> codec supports EPSS, thus making "sup" negative. And the bit 28:5 is
> reserved as "0".
> > So a negative value other than -1 shall be further checked.
> >
> > Please refer to High-Definition spec 7.3.4.12 "Supported Power States",
> thanks!
> >
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> 
> Could you resend in a normal text?  It's garbled badly with HTML in the
> signature and can't be applied.
> 
> Also, try to shorten the subject a bit more.
> 
> 
> thanks,
> 
> Takashi
