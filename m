From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 18/31] HDA patch_via.c: Add 48K sample rate
	limit for S/PDIF streams.
Date: Mon, 5 Oct 2009 18:07:27 -0600
Message-ID: <51f3faa70910051707m611b5bc9x4ab1376256822b5b@mail.gmail.com>
References: <16685ee0910050727k409b03fdj1b03afd9c9521db2@mail.gmail.com>
	<s5h4oqd6ff0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f199.google.com (mail-iw0-f199.google.com
	[209.85.223.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 774C41037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 02:07:28 +0200 (CEST)
Received: by iwn37 with SMTP id 37so1878995iwn.16
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 17:07:27 -0700 (PDT)
In-Reply-To: <s5h4oqd6ff0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Li Bo <liboat@gmail.com>, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, LoganLi@viatech.com.cn, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 5, 2009 at 9:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 5 Oct 2009 22:27:43 +0800,
> Li Bo wrote:
>>
>> [ALSA] HDA VIA: Add 48K sample rate limit for S/PDIF streams.
>>
>> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>
> Any reason?

Indeed, if this is required it's a pretty bad limitation..
