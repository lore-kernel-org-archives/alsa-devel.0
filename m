From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Audio miniconference at LPC/KS confirmed-
Date: Sat, 22 Oct 2016 08:42:15 +0900
Message-ID: <6cfff6e4-5aaa-d4e6-8d78-18207788ef9c@sakamocchi.jp>
References: <20160701155438.GU6247@sirena.org.uk>
 <20160825153940.GF6635@sirena.org.uk>
 <4788d7ff-0fd7-9d62-be74-72c5a143c999@sakamocchi.jp>
 <20161020141138.GM10208@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 372AB265654
 for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2016 01:42:20 +0200 (CEST)
In-Reply-To: <20161020141138.GM10208@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,

On Oct 20 2016 23:11, Mark Brown wrote:
> On Thu, Oct 20, 2016 at 10:30:16PM +0900, Takashi Sakamoto wrote:
> 
>> Are there any spaces for me to join in the audio workshop at 1st day of
>> the conference? (I already have my ticket for the conference itself.)
> 
> Yes, absolutely - anyone who's got a ticket for Plumbers or Kernel
> Summit is more than welcome to attend.

OK, thanks.

>From me, additional three items to discuss.

1. Add tracepoints to pcm parameter processing in ALSA PCM core
In my memory of our previous mini audio conference, some issuers are
addressed about pcm parameters. This is my WIP related to it. The aim is
to monitor changes of pcm parameter refinement processing just after
calling ioctl(HW_REFINE/HW_PARAMS). See my working branch:
https://github.com/takaswie/sound/tree/trace-rules

2. Userspace control service daemon via ALSA control interfaces
For some devices for USB audio device class and Audio and Music units on
IEEE 1394 bus, we can put codes to control their states in userspace
because packet transferring can be done in userspace with proper
privilege. This may be a reasonable way to implement driver for
vendor-unique features.

3. Dropping dice driver from ALSA firewire stack
A fatal quirk apperard that the most of TCAT ASIC called as 'DICE'
breaks the least significant protocol as a sound device[1][2]. The
chipsets don't transfer PCM frames as the same as current sampling
frequency (it's sampling transfer frequency in IEC 61883-6 word).
This is my suggestion to drop dice driver from ALSA firewire stack.

[1] [alsa-devel] Dice packet sequence quirk and ALSA firewire stack in
Linux 4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html
[2] [alsa-devel] Clicking issues with the output of an Onyx Blackbird
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/113509.html


Regards

Takashi Sakamoto
