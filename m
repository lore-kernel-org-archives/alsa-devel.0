From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/1] ALSA: hda - bug fix for
	invalid	connection list of Haswell HDMI codec pin
Date: Fri, 14 Dec 2012 07:26:28 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82946F1@SHSMSX101.ccr.corp.intel.com>
References: <1355511450-2031-1-git-send-email-mengdong.lin@intel.com>
 <s5hk3slqfda.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id F40272616FA
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 08:26:32 +0100 (CET)
In-Reply-To: <s5hk3slqfda.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Friday, December 14, 2012 3:10 PM

> > +static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
> > +			       const struct hda_fixup *fix, int action) {
> > +	hda_nid_t list[3] = {0x2, 0x3, 0x4};
> > +	unsigned int vendor_param;
> > +
> > +	if (action != HDA_FIXUP_ACT_PROBE)
> > +		return;
> 
> Is this ACT_PROBE, that is, applied only after parsing the codec?
> Usually a fixup for overriding the connection list is applied before parsing the
> tree.


Yes, this fixup is applied after parsing the codec.
Because during parsing, the pin nid#6 may still report invalid connection list entries 0x00000000
in snd_hda_get_raw_connections(), which should be 0x00040302 to stand for 3 output convertors.
So we need to overwrite its connection list with the proper value.

But, do you mean we can change this to the pre-probe stage, so that snd_hda_get_raw_connections()
need not be called during the parsing the codec? I'll do a test.

Thanks
Mengdong
