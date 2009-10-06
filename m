From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 0/31] HDA patch_via.c update
Date: Tue, 6 Oct 2009 12:56:08 +0800
Message-ID: <16685ee0910052156l60fe81fo2f3639644a38ce08@mail.gmail.com>
References: <16685ee0910050615t2f68c4efp71aeb5a9509dd12a@mail.gmail.com>
	<51f3faa70910051842lb8aeef3yaef180085b33f444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C6B2103850
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 06:56:08 +0200 (CEST)
Received: by fxm8 with SMTP id 8so3307672fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 21:56:08 -0700 (PDT)
In-Reply-To: <51f3faa70910051842lb8aeef3yaef180085b33f444@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, LoganLi@viatech.com.cn, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

Hi, Robert
  Thank you for reply. We will test VT18128S S/PDIF function later.
  About 48 kHz sample rate limit, it is set for HW's stable work. Other
  sample rate can also work, if you need them just ignore this patch.

On Tue, Oct 6, 2009 at 9:42 AM, Robert Hancock <hancockrwd@gmail.com> wrote:
> On Mon, Oct 5, 2009 at 7:15 AM, Li Bo <liboat@gmail.com> wrote:
>> Hi!
>>
>> Following are a series of patches for patch_via.c, started from git clone of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6 recently.
>>
>> Please have a review and give comments, thank you!
>>
>> Outlook Access Web cannot send plain-text mail, so my gmail is used
>> instead.
>> You can also contact with me with LoganLi@viatech.com.cn, or
>> mail to HaraldWelte@viatech.com and lydiawang@viatech.com.cn.
>
> OK, I just tried this patchset on my Asus P7P55D PRO (VIA VT1828S).
> Good news is that the analog 5.1 output and microphone input appear to
> work fine. However I am getting no output on SPDIF optical output at
> all, the jack doesn't even light up which suggests that the codec
> isn't powering on the SPDIF port, or something like that.
>
> I've seen a few of these messages in dmesg while poking around with
> things, they may or may not be related:
>
> ALSA sound/pci/hda/hda_intel.c:683: No response from codec, disabling
> MSI: last cmd=0x01ef0100
> ALSA sound/pci/hda/hda_intel.c:698: azx_get_response timeout,
> switching to polling mode: last cmd=0x01ef0100
>
> ALSA sound/pci/hda/hda_intel.c:683: No response from codec, disabling
> MSI: last cmd=0x024f0900
> ALSA sound/pci/hda/hda_intel.c:698: azx_get_response timeout,
> switching to polling mode: last cmd=0x024f0900
>
> ALSA sound/pci/hda/hda_intel.c:683: No response from codec, disabling
> MSI: last cmd=0x021f0200
> ALSA sound/pci/hda/hda_intel.c:698: azx_get_response timeout,
> switching to polling mode: last cmd=0x021f0200
>
> I also tested in Windows and SPDIF output works (obviously) with rates
> up to 192KHz, so I'm not sure why this patch set limits it to 48KHz
> only..
>
