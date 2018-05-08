From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ALSA: hda: Add Lenovo C50 All in one to
 the power_save blacklist
Date: Tue, 8 May 2018 09:30:53 +0200
Message-ID: <3c1b30ca-b688-dfcb-3994-5d79a7ed9b96@redhat.com>
References: <20180508072746.10798-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 403C1267677
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 09:30:55 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id i14-v6so27992427wre.2
 for <alsa-devel@alsa-project.org>; Tue, 08 May 2018 00:30:55 -0700 (PDT)
In-Reply-To: <20180508072746.10798-1-hdegoede@redhat.com>
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 08-05-18 09:27, Hans de Goede wrote:
> Power-saving is causing loud plops on the Lenovo C50 All in one, add it
> to the blacklist.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1572975
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Note I just realized this will not apply cleanly, I've 3 patches in my
local tree adding power_save quirks and I'm still waiting for feedback
on the 2 others. I did not realize this one depended on the others.

I will send out the entire series when I've test results on the
other 2 models.

Regards,

Hans


> ---
>   sound/pci/hda/hda_intel.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 0981c3c64d87..9a16af179503 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2214,6 +2214,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
>   	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
>   	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
>   	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
> +	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
> +	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
>   	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
>   	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
>   	{}
> 
