From: Torben Schulz <public@letorbi.de>
Subject: Re: [PATCH 1/1] ALC889A chip identification
Date: Fri, 15 May 2009 19:52:55 +0200
Message-ID: <4A0DABF7.1080200@letorbi.de>
References: <4A0CB87F.70405@letorbi.de>	<s5h4ovm3oeh.wl%tiwai@suse.de>
	<s5h8wky9yqu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lvps87-230-79-166.dedicated.hosteurope.de
	(lvps87-230-79-166.dedicated.hosteurope.de [87.230.79.166])
	by alsa0.perex.cz (Postfix) with ESMTP id B184E1039B9
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 19:53:29 +0200 (CEST)
In-Reply-To: <s5h8wky9yqu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 15 May 2009 07:50:46 +0200,
> I wrote:
>> BTW, regarding the strings: basically we can do a better clean-up by
>> using already existing strings.  For example, make new fields,
>> hda_codec.vendor_name and hda_codec.chip_name, which points the vendor
>> id string in hda_codec.c and the chip name string in
>> snd_hda_codec_preset struct respectively.  Then all PCM name strings
>> can be created automatically.
> 
> The patch is something like below.  It's just compile tested.

I just applied your patch the latest snapshot and it works perfect. My chipset is now identified correctly, so my patch seems to be obsolete now, I guess ^^ However, I have three (main) questions:

1.: What are the next steps now? Will you post your patch again to the ML under an own topic or will it stay in this thread?

2.: Can I do anything to help bringing your patch into the official repository? When will it be part of an official snapshot?

3.: Why doesn't hda_codec_preset.patch point to patch_alc883, but to patch_alc882 which later redirects to patch_alc883 (see patch_realtek.c line 7305 and 16958 (patched version))?

It's quite essential for me to bring this patch into an official snapshot, since a lot of the changes interact with my MacBook3,1 patch and I would like to diff against a snapshot which includes your patch already. (or is this - for some reason - bad style?)

Bai
Torben
