From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 1/1] ALSA: hda - bug fix for invalid
 connection list of Haswell HDMI codec pins
Date: Thu, 17 Jan 2013 03:23:27 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82D442F@SHSMSX101.ccr.corp.intel.com>
References: <1355867955-2391-1-git-send-email-mengdong.lin@intel.com>
 <50F534AB.3010207@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A30D26167D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 04:23:32 +0100 (CET)
In-Reply-To: <50F534AB.3010207@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Tuesday, January 15, 2013 6:51 PM


> When trying to get Haswell HDMI audio working, I discovered that this verb
> when executed can get pins to change state from D0 to D3.
> 
> As the fixup is executed after hda_call_codec_resume this means that the
> pins will remain in D3. I'm not entirely sure of this, but I think we have no
> runtime power transitions if we are on AC power, so this could potentially be
> for a very long time.

Hi David,

Is the "power save" enabled for the codec, by setting a non-zero value to the 
"power_save" parameter under /sys/module/snd_hda_intel/parametesrs?

The verb 0x0f81/0x0781/ is a vendor verb to query/configure HDMI, but it will
not touch the pin's D-state.

I suspect the codec is suspended in D3 during the interval between commands
execution, since codec_exec_verb() will call snd_hda_power_down() after a 
command is done and so the codec will be suspended if 'power save' is enabled. 
And snd_hda_codec_read() just tries to resume the codec when executing a 
new command, the calling sequence is snd_hda_codec_read-> codec_exec_verb
-> snd_hda_power_up.

> 
> > +	/* override 3 pins connection list */
> > +	snd_hda_override_conn_list(codec, 0x05, 3, list);
> > +	snd_hda_override_conn_list(codec, 0x06, 3, list);
> > +	snd_hda_override_conn_list(codec, 0x07, 3, list);
> 
> So before the DP 1.2 verb is executed, the connections are just 5 -> 2, 6 -> 3,
> 7 -> 4, but afterwards, every pin node can connect to every cvt node, and
> connection select verbs must change as a result?

Yes. Without DP 1.2 there is a 1:1 mapping between pins and convertors. But HDMI 
cannot play sound. And even DP 1.2 is enabled, HDMI codec can still report invalid 
empty connect list during initialization. This is a HW issue for Haswell B0 processor.

Which version of Haswell processor is on your machine? Could you share the 
'cpu stepping' in BIOS under platform information menu. 

We'll verify this issue and side effect of the patch after we got a processor upgrade.

Sorry for the late reply.

Thanks
Mengdong
