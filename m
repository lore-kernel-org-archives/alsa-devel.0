From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 1/1] ALSA: hda - bug fix for invalid
 connection list of Haswell HDMI codec pins
Date: Thu, 17 Jan 2013 05:32:23 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82D44F4@SHSMSX101.ccr.corp.intel.com>
References: <1355867955-2391-1-git-send-email-mengdong.lin@intel.com>
 <50F534AB.3010207@canonical.com> <s5h1udmisu0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EED1262615
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 06:32:27 +0100 (CET)
In-Reply-To: <s5h1udmisu0.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, January 15, 2013 7:33 PM
> > When trying to get Haswell HDMI audio working, I discovered that this
> > verb when executed can get pins to change state from D0 to D3.
> 
> Oh, does this verb do it?  It's bad.

No, I think these verbs ((0x781 & 0xf81) don't change pin state. 
So I'm asking David to share more Information.

> Also, Mengdong, could you define these verbs (0x781 & 0xf81) in
> hda_codec.h to understand and read the code better?

Okay, I will.

> > As the fixup is executed after hda_call_codec_resume this means that
> > the pins will remain in D3. I'm not entirely sure of this, but I think
> > we have no runtime power transitions if we are on AC power, so this
> > could potentially be for a very long time.
> 
> Actually you spotted a potential bug -- the code isn't called in the resume
> callback.  This is a code called directly from parse_generic_hdmi(), so it's
> called only once to override the connections.  But the verb 0x781 isn't set.

Yes. intel_haswell_fixup_connect_list() is called only once from 
parse_generic_hdmi().

> I thought we can simply replace the call  snd_hda_codec_read(codec, 0x08,
> 0, 0x781, ...) with snd_hda_codec_write_cache(), so that the same verb will
> be executed automatically on resume.  But, if this verb has any bad side
> effect (like touching D state), it's no good idea to do it in the cache resume.
> 

But at first, we need to find out whether snd_hda_codec_read (codec, 0x08, 0, 0x781, ...)
cannot bring the codec out of D3 before executing 0x781. I suspect it's not the executing
the verb but before that that the whole codec (including the pins) enters D3.

Thanks
Mengdong
