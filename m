From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix runtime PM accounting
Date: Wed, 29 Aug 2012 12:19:32 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81DAFDF@SHSMSX101.ccr.corp.intel.com>
References: <s5hwr0l7msk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DA4D0@SHSMSX101.ccr.corp.intel.com>
 <s5h7gsj6i6x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AAD96265CBD
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2012 14:19:35 +0200 (CEST)
In-Reply-To: <s5h7gsj6i6x.wl%tiwai@suse.de>
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

> Now I introduced codec->epss flag that is initialized once in
> snd_hda_codec_new(), and let the codec driver overrides this flag.
> One bonus is that you can avoid the unnecessary codec parameter read at
> each power change.

Yes, this is better. And the patch works well for me - [PATCH 1/2] ALSA: hda - Avoid unnecessary parameter read for EPSS.

> In anyway, there are a few issues:
> - The refcounting gets broken after module unload.  It's because we
>   leave the codec's pm_runtime usages after removal.

Thanks for pointing out this! But I think the following codec can introduce risk of race among multiple codecs to modify ' chip->power_count',
because only one codec's power on/off is serialized.
static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec)
{
	 ...
	if (codec->power_on) {
		pm_runtime_get_sync(&chip->pci->dev);
		chip->power_count++;
	} else {
		pm_runtime_put_sync(&chip->pci->dev);
		chip->power_count--;
	}
}

How about calling pm_runtime_put_noidle() when freeing a codec in D0? 
Maybe we can add a bus notify function like this:
Static void azx_codec_free_notify(struct hda_codec *codec)
{
	If(codec->power_on)
		pm_runtime_put_noidle(&codec->bus->pci->dev);
}
And snd_hda_codec_free() can trigger this notify.

> - The D3-stop-clock check isn't done properly for the codecs providing
>   own set_power_state ops.

I cannot test the branch 'if (codec->patch_ops.set_power_state)' in hda_set_power_state() for lack of such a codec. 
But the logic seems right and the other branch works well for me :-)

> - Ditto for the repeated power-set sequence, the error check, etc.
In hda_sync_power_state(), 
	if ((state & 0xff) == power_state)   ... should be if ((state & 0xf0)>> 4 == power_state), because PS-Act is bits 7:4
		break;

And would you please explain why changing to D3 need not wait? One of my codec does have a delay on change from D0 to D3.

Thanks
Mengdong
