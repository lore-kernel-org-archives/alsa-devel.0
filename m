From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] ALSA: hda - Fix applying MSI dual-codec mobo quirk
Date: Fri, 2 Jun 2017 12:12:03 +0300
Message-ID: <a6702e31-ba47-e240-8af2-62de74d89c89@cogentembedded.com>
References: <20170601205850.24993-1-tiwai@suse.de>
 <20170601205850.24993-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170601205850.24993-2-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello!

On 6/1/2017 11:58 PM, Takashi Iwai wrote:

> The previous commit [63691587f7b0: ALSA: hda - Apply dual-codec quirk
> for MSI Z270-Gaming mobo] attempted to apply the existing dual-codec

    The standard way of citing a commit is: commit 63691587f7b0 ("ALSA: hda - 
Apply dual-codec quirk for MSI Z270-Gaming mobo"), just like in the Fixes: tag.

> quirk for a MSI mobo.  But it turned out that this isn't applied
> properly due to the MSI-vendor quirk before this entry.  I overlooked
> such two MSI entries just because they were put in the wrong position,
> although we have a list ordered by PCI SSID numbers.
>
> This patch fixes it by rearranging the unordered entries.
>
> Fixes: 63691587f7b0 ("ALSA: hda - Apply dual-codec quirk for MSI Z270-Gaming mobo")
> Reported-by: Rudolf Schmidt <info-3q2wXJgvQBgtTFl30EOYJwC/G2K4zDHf@public.gmane.org>
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
