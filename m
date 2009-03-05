From: Dmitry Baikov <dsbaikov@gmail.com>
Subject: Re: Fwd: [LAD] kernel 2.6.29 rc6 no working rme
	multiface 1
Date: Thu, 5 Mar 2009 12:04:33 +0300
Message-ID: <70a871c80903050104k697a6245m2518a63efa3d5266@mail.gmail.com>
References: <20090302025929.64889223@rt-ente>
	<70a871c80903011849r586443e4h7188747ac01cbaf3@mail.gmail.com>
	<70a871c80903011959s9e4c94ds62aa0e88b4f2c040@mail.gmail.com>
	<s5hhc2bdg36.wl%tiwai@suse.de>
	<70a871c80903021454u7e644a56lba1814fec69f1494@mail.gmail.com>
	<s5h3advoz0t.wl%tiwai@suse.de>
	<70a871c80903031806t766337fet7ceecd243ee1694e@mail.gmail.com>
	<s5h4oy9stb2.wl%tiwai@suse.de>
	<70a871c80903041022o2c52b3baudec682508977e963@mail.gmail.com>
	<s5hocwgfla7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id A729F1037EE
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 10:04:34 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c5so3569998anc.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2009 01:04:33 -0800 (PST)
In-Reply-To: <s5hocwgfla7.wl%tiwai@suse.de>
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

On 3/5/09, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 4 Mar 2009 21:22:29 +0300,
> Dmitry Baikov wrote:
>>
>> >
>> >> If I additionally apply Tim's patch, I get (coldplugged)
>> >> NULL pointer dereference at 0000000000000140
>> >
>> > What is Tim's patch?  Could you attach or give the commit id if it's
>> > already in the git tree?
>>
>> Here it goes:
>>
>> >> http://article.gmane.org/gmane.linux.alsa.devel/60411
>> >
>> > looks like a good patch to me. i hope it gets pushed into ALSA soon.
>>
>> takashi applied it to the sound-2.6 git repository:
>> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=e588ed8304f76cbb396ee85e657a58990298a675
>
> Weird.  It's just adds more check in snd_hdsp_load_firmware_from_cache(),
> but has nothing to do with the interrupt handling.


I checked kernel with your patch only, and with Tim's patch added.
I did it twice, every time building from scratch.

Btw, with 2.6.24 the card does not work also, it's can't load firmware.
This all started after upgrade. I now have Asus P5Q board (Intel P45 chipset).
I think I should test the card in another 2 PCI slots.


Dmitry.
