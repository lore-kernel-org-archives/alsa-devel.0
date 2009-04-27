From: Aleh <aleh.fl@gmail.com>
Subject: Re: Benq S32 headphones detection
Date: Mon, 27 Apr 2009 18:38:05 +0300
Message-ID: <op.us1xprp539g8cz@flip>
References: <op.ust0kjam39g8cz@flip> <s5h8wlr8wcz.wl%tiwai@suse.de>
	<op.usuuqios39g8cz@flip> <s5hk556h0aq.wl%tiwai@suse.de>
	<op.us1w4fpm39g8cz@flip> <s5hskju3yjp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E2A12457D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 17:38:10 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2563645bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 08:38:09 -0700 (PDT)
In-Reply-To: <s5hskju3yjp.wl%tiwai@suse.de>
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

On Mon, 27 Apr 2009 18:29:30 +0300, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 27 Apr 2009 18:25:18 +0300,
> Aleh wrote:
>>
>> On Mon, 27 Apr 2009 13:13:17 +0300, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> > At Thu, 23 Apr 2009 22:50:32 +0300,
>> > Aleh wrote:
>> >>
>> >> On Thu, 23 Apr 2009 14:04:12 +0300, Takashi Iwai <tiwai@suse.de>  
>> wrote:
>> >> > At Thu, 23 Apr 2009 11:58:58 +0300
>> >> > Aleh wrote:
>> >> >>
>> >> >> Hi,
>> >> >>
>> >> >> I had a problem with muting speakers when headphones are  
>> plugged-in
>> >> on
>> >> >> my
>> >> >> Benq S32B. So I added proper board configuration to
>> >> >> sound/pci/hda/patch_realtek.c and now it works.
>> >> >>
>> >> >> I wonder if anyone has similar hardware (S-series Benq laptop) to
>> >> test
>> >> >> the
>> >> >> patch (attached) if you find it useful.
>> >> >
>> >> > Thanks for the patch.
>> >> > The lack of headphone mute is likely because of codec SSID value.
>> >> > The realtek codec is supposed to have some special SSID indicating
>> >> > the assembly information, but many vendors don't follow it.
>> >> >
>> >> > Could you try the patch below and try model=auto?  It's found in
>> >> > sound-unstable tree, too...
>> >>
>> >>
>> >> Downloaded and installed
>> >>       
>> http://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/alsa-driver-unstable-snapshot.tar.bz2
>> >> in accordance with those instructions:
>> >>      http://alsa-project.org/main/index.php/Matrix:Module-hda-intel
>> >>
>> >> loaded it with option 'model=auto' as you suggested, launched mplayer
>> >> and
>> >> plugged/unplugged headphones several times.
>> >> Unfortunately, those actions weren't recognized and laudspeakers
>> >> continued
>> >> playing without any interruption.
>> >
>> > OK, I found a problem.  The hook wasn't activated for ALC262.
>> > I fixed the patch now.  Could you retry the unstable snapshot again?
>>
>> Gave a try to today's snapshot - the problem still exists as headphones
>> haven't been detected.
>
> With alsa-driver-unstable snapshot tarball?
> What is the first line of alsa-driver*/alsa-kernel/HEAD file?
>
>
> Takashi


31d2caf87f5dc5700897ff820c08e84ca35fcffb Merge commit 'stable/master'
