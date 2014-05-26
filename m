From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 4/5] ALSA: hda - drop def association and
 sequence from pinconf comparing
Date: Mon, 26 May 2014 12:11:54 +0200
Message-ID: <5383136A.3040006@canonical.com>
References: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
 <1401092564-14293-4-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A3FD261B2A
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 12:11:54 +0200 (CEST)
In-Reply-To: <1401092564-14293-4-git-send-email-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>, tiwai@suse.de, alsa-devel@alsa-project.org, alex.hung@canonical.com
List-Id: alsa-devel@alsa-project.org

(Add Alex Hung to CC)

On 2014-05-26 10:22, Hui Wang wrote:
> A lot a machine have the same codec, but they have different default
> pinconf setting just because the def association and sequence is
> different, as a result they can't share a hda_pintbl[], to overcome
> it, we don't compare def association and sequence in the pinconf
> matching.

Uhm, really? Alex, does this seem reasonable from a BIOS perspective, i 
e, that BIOS people normally would set def association and sequence 
different while leaving everything else unchanged?

>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   sound/pci/hda/hda_auto_parser.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
> index b684c6e..3cf9137 100644
> --- a/sound/pci/hda/hda_auto_parser.c
> +++ b/sound/pci/hda/hda_auto_parser.c
> @@ -844,7 +844,8 @@ static bool pin_config_match(struct hda_codec *codec,
>   {
>   	for (; pins->nid; pins++) {
>   		u32 def_conf = snd_hda_codec_get_pincfg(codec, pins->nid);
> -		if (pins->val != def_conf)
> +		u32 mask = 0xffffff00;
> +		if ((pins->val & mask) != (def_conf & mask))
>   			return false;
>   	}
>   	return true;
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
