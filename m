From: Vlad Catoi <vcatoi@gmail.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Fri, 07 Nov 2014 22:24:03 -0600
Message-ID: <1415420643.2456.5.camel@kgwgk>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
 <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
 <531EC9CC.4060203@ladisch.de>
 <88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
 <545895AD.7020004@ladisch.de>	<545A697C.5070800@bobobeach.com>
 <545A93E3.7020906@ladisch.de>	<545B9C57.1070304@bobobeach.com>
 <s5hmw841dh2.wl-tiwai@suse.de> <545BA7C2.5010402@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id E8B5C26044C
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 05:24:07 +0100 (CET)
Received: by mail-qc0-f171.google.com with SMTP id m20so3570305qcx.2
 for <alsa-devel@alsa-project.org>; Fri, 07 Nov 2014 20:24:07 -0800 (PST)
In-Reply-To: <545BA7C2.5010402@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Cyrus,

There's an automated patcher for the UR22 on Ubuntu @ Steinberg forums -
maybe you can adapt it for your purposes.

http://pastebin.com/awiG30Eh
http://www.steinberg.net/forums/viewtopic.php?t=62290

~Vlad

On Thu, 2014-11-06 at 08:54 -0800, Cyrus Harmon wrote:
> That's what I was looking for!
> 
> Thanks!
> 
> On 11/06/2014 08:49 AM, Takashi Iwai wrote:
> > At Thu, 06 Nov 2014 08:05:43 -0800,
> > Cyrus Harmon wrote:
> >>
> >> On a somewhat related note, is there a way to apply changes to things
> >> in, say, sound/usb and compile/install those changes without a few
> >> kernel rebuild/install? Or, even better, without a reboot? Would
> >> certainly shorting the debug cycle time for me. In this case I'm
> >> interested in finding out what quirk->type is when it gets to
> >> snd_usb_create_quirk as it looks like the function in the quirk_funcs
> >> table that gets called here produces the first suspect error. Adding a
> >> dev_info, followed by a kernel rebuild, reinstall, reboot (and the fact
> >> that my broken nvidia drivers require reinstalling the video driver
> >> every time I install a new kernel) makes for a tedious process!
> > It's a standard procedure, something like...
> >
> > 	% mkdir /somewhere
> > 	% cd /somewhere
> > 	% cp -a /there/linux/sound .
> > 	% patch -p1 < your-usb.patch
> > 	% make -C /lib/modules/`uname -r`/build M=$PWD/sound/usb
> > 	% su
> > 	# make -C /lib/modules/`uname -r`/build M=$PWD/sound/usb modules_install
> > 	# modprobe -r snd-usb-audio
> > 	# modprobe snd-usb-audio
> >
> >
> > Takashi
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
