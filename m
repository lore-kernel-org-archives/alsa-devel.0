From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: RFC: snd_card_create() function
Date: Mon, 12 Jan 2009 15:06:51 +0000
Message-ID: <ad2655cb0901120706g1bfe019bk23316a288c08ee7b@mail.gmail.com>
References: <s5h63kkd23c.wl%tiwai@suse.de>
	<ad2655cb0901120642h542f2a5s9f3e9bb05e6e176c@mail.gmail.com>
	<s5h4p04d1ij.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FE8F1037EC
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 16:06:53 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so4097906fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 07:06:53 -0800 (PST)
In-Reply-To: <s5h4p04d1ij.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/1/12 Takashi Iwai <tiwai@suse.de>:
> At Mon, 12 Jan 2009 14:42:06 +0000,
> James Courtier-Dutton wrote:
>>
>> Sounds good to me.
>> One can keep the wrapper outside of the kernel, and only available in
>> alsa-driver for those out of tree people.
>
> Yes, that's good.
> I think it'd be better to do that after one kernel-cycle later for a
> softer landing, though.
>

How soft do we need this?
The change is probably max of 3 lines of code per sound card that has
an out of tree driver.
The only one I am aware of is the xfi one. With the wrapper being more
than 3 lines of code being put into the kernel only to be removed
again seems a little un-necessary to me.
For internal kernel changes, I don't think we should care about out of
kernel drivers. None of the rest of the kernel developers go out of
their way for anything out-of-mainline.

Kind Regards

James
