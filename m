From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Clicking issues with the output of an Onyx
	Blackbird
Date: Thu, 13 Oct 2016 08:17:11 +0900
Message-ID: <ef1aaf43-d7d6-0df3-0898-f52f59181f65@sakamocchi.jp>
References: <CACF1cz+9Y9cGL1W7_t2y0jm=WUWaw1uc8q5AWrrnVjzAdVvykw@mail.gmail.com>
 <CACF1czJDEDoXt_pEiwvS0CQzmXujWUS8EctJbD5izBr4-ieiGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 0596E266C5E
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 01:17:16 +0200 (CEST)
In-Reply-To: <CACF1czJDEDoXt_pEiwvS0CQzmXujWUS8EctJbD5izBr4-ieiGg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jordi Torres <clubmajo@yahoo.es>, ffado-devel@lists.sourceforge.net
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
(CCed to alsa-devel)

I'm an ALSA developer currently commits to drivers for Audio and Music
units on IEEE 1394 bus.

On Oct 13 2016 04:15, Jordi Torres wrote:
> I have an Onyx Blackbird that uses a firewire DICE II chip. This
> device works correctly using a Power Mac G5 with Mac OS X 10.5 but
> using another computer with linux, all works but there is a clicking
> issue in the output of the device.
> 
> I tested the input and works correctly without the clicking. I tried
> use the alsa stack without jackd and it has the same issue. I tried vary
> a lot of configurations and I found that clicking sound varies when
> the sample rate is different
> 
> ffado-diag: http://pastebin.com/u7g93GqD
> ffado-test Discover: http://pastebin.com/qBMQwWMq
> 
> I provide samples of the clicking sound in the next file:
> https://drive.google.com/file/d/0Bz44Dr5G2FeJOEdCT21sLUFFWlU/view?usp=sharing
> These samples are Audacity projects where 1st track is the original
> sound and 2nd track is the Blackbird ouput sound that was recorded in
> a Focusrite Saffire PRO I/O 10 using input line
> The spectrum shows regular patterns that could be useful to the issue
> 
> If anyone needs more info, please don't hesitate to ask

Current ALSA dice driver has an issue of packet timestamping, which
causes periodical noises. This issue comes from quirks of packet
sequence to/from Dice chipset. In detail, see:

[alsa-devel] Dice packet sequence quirk and ALSA firewire stack in Linux 4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html

I know this issue is potentially in current FFADO implementation, too.

Well, could I request you to gather information of packet sequence? In
Linux 4.7, ALSA firewire stack get tracepoints. Via the tracepoints, we
can gather enough information to diagnose the sequence from user space.

To gather the information, please use trace-cmd (or perf) command, like:
$ sudo trace-cmd list | grep fire
snd_firewire_lib:in_packet
snd_firewire_lib:out_packet
$ sudo trace-cmd record -e snd_firewire_lib:in_packet -e
snd_firewire_lib:out_packet

Then execute ALSA applications. When terminate trace-cmd, you can get
trace.dat in your current working directory. Please send it to me via
some better ways (it may be too big to attach e-mail).

When read the content of data, run:
$ trace-cmd report trace.dat

In detail, read:
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/amdtp-stream-trace.h?id=0c95c1d6197f3edd3f6ef76f927d67e8ec0794ed


Regards

Takashi Sakamoto
