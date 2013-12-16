From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Where to find recent fix for HD-Audio runtime PM?
Date: Mon, 16 Dec 2013 05:36:21 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80143ACBE@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F801437B35@SHSMSX101.ccr.corp.intel.com>
 <s5hbo0kizv1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FEC6261B30
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 06:36:31 +0100 (CET)
In-Reply-To: <s5hbo0kizv1.wl%tiwai@suse.de>
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

Many thanks for your patches, Takashi!
They fixed the PM bug on the kernel v3.9.

Regards
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, December 13, 2013 10:34 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: Where to find recent fix for HD-Audio runtime PM?
> 
> At Fri, 13 Dec 2013 14:30:04 +0000,
> Lin, Mengdong wrote:
> >
> > Hi Takashi,
> >
> > If convenient, would you please point out your previous patches to
> make HD-Audio runtime PM stable?
> > I guess 'ALSA: hda - Refactor pm notification in hda_codec.c' is only one
> of them.
> >
> > We observed audio failure (dead communication) after S3 if runtime PM
> is enabled on Haswell with Kernel v3.9.
> > We hope to back port your previous fix and further check this issue.
> 
> The S3 problem might be rather the runtime refcount unbalance.  There
> are multiple fixes: e6bbe666673ab044a3d39ddb74e4d9a401cf1d6f and
> commit 0fc28fc030a85aa3d6d14e9e9fca0c8237c9ffb5
> 
> 
> Takashi
