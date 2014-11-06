From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Thu, 06 Nov 2014 08:54:26 -0800
Message-ID: <545BA7C2.5010402@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>	<531DAB14.5080201@ladisch.de>	<76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>	<531DDD04.5050902@ladisch.de>	<0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>	<531EC9CC.4060203@ladisch.de>	<88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>	<545895AD.7020004@ladisch.de>	<545A697C.5070800@bobobeach.com>	<545A93E3.7020906@ladisch.de>	<545B9C57.1070304@bobobeach.com>
 <s5hmw841dh2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspen.bobobeach.com (unknown [208.79.93.82])
 by alsa0.perex.cz (Postfix) with ESMTP id AE1D2265275
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 17:54:28 +0100 (CET)
In-Reply-To: <s5hmw841dh2.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

That's what I was looking for!

Thanks!

On 11/06/2014 08:49 AM, Takashi Iwai wrote:
> At Thu, 06 Nov 2014 08:05:43 -0800,
> Cyrus Harmon wrote:
>>
>> On a somewhat related note, is there a way to apply changes to things
>> in, say, sound/usb and compile/install those changes without a few
>> kernel rebuild/install? Or, even better, without a reboot? Would
>> certainly shorting the debug cycle time for me. In this case I'm
>> interested in finding out what quirk->type is when it gets to
>> snd_usb_create_quirk as it looks like the function in the quirk_funcs
>> table that gets called here produces the first suspect error. Adding a
>> dev_info, followed by a kernel rebuild, reinstall, reboot (and the fact
>> that my broken nvidia drivers require reinstalling the video driver
>> every time I install a new kernel) makes for a tedious process!
> It's a standard procedure, something like...
>
> 	% mkdir /somewhere
> 	% cd /somewhere
> 	% cp -a /there/linux/sound .
> 	% patch -p1 < your-usb.patch
> 	% make -C /lib/modules/`uname -r`/build M=$PWD/sound/usb
> 	% su
> 	# make -C /lib/modules/`uname -r`/build M=$PWD/sound/usb modules_install
> 	# modprobe -r snd-usb-audio
> 	# modprobe snd-usb-audio
>
>
> Takashi
