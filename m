From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: 2.6.18 unknown symbol ksize error
Date: Sat, 30 Jun 2012 11:28:34 +0200 (CEST)
Message-ID: <41403.175.39.33.120.1341048514.squirrel@boosthardware.com>
References: <28300.101.169.127.232.1339918064.squirrel@boosthardware.com>
	<4FDEE5E2.70604@ladisch.de> <s5hfw9tnevr.wl%tiwai@suse.de>
	<61144.175.39.33.120.1340503011.squirrel@boosthardware.com>
	<s5hpq8o345a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FA6C245CB
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 11:28:37 +0200 (CEST)
In-Reply-To: <s5hpq8o345a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sun, June 24, 2012 9:23 pm, Takashi Iwai wrote:
> At Sun, 24 Jun 2012 03:56:51 +0200 (CEST),
> Patrick Shirkey wrote:
>>
>>
>> On Mon, June 18, 2012 11:33 am, Takashi Iwai wrote:
>> > At Mon, 18 Jun 2012 10:25:06 +0200,
>> > Clemens Ladisch wrote:
>> >>
>> >> Patrick Shirkey wrote:
>> >> > I have compiled the latest stable alsa drivers against 2.6.18
>> kernel
>> >> with
>> >> > gcc-4.1.
>> >> >
>> >> > I am getting an error when I insert the sound card modules.
>> >> >
>> >> >     snd_rawmidi: Unknown symbol ksize
>> >> >
>> >> > As far as I can tell 2.6.18 has support for ksize so I am not sure
>> >> where
>> >> > this error is coming from.
>> >>
>> >> That kernel didn't export ksize.
>> >>
>> >> Try --with-debug=memory to get a separate allocator implementation.
>> >
>> > Indeed.  The patch below (untested) forces to enable
>> > CONFIG_SND_DEBUG_MEMORY on older kernels.  Let me know if this helps.
>> >
>>
>> Seems to be worse now. Compiling with gcc-4.1 because that is the latest
>> version of gcc we can get on this old system without having to go
>> wholesale LFS on it. Upgrading alsa and jack is a big step for this
>> machine. If this is in the too hard basket I'll compile a new kernel
>> instead.
>>
>> Now seeing the following errors from dmesg:
>>
>> snd_hidden_kmalloc
>> snd_timer: Unknown symbol snd_register_device_for_dev
> ...
>
> Then try simple passing --with-debug=full configure option.
>
>

It's the same results with both methods.

Any other ideas or should I go ahead with compiling a new kernel?



--
Patrick Shirkey
Boost Hardware Ltd
