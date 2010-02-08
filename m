From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH -next] ASoC: pandora: Add DAC regulator
	support
Date: Mon, 8 Feb 2010 14:29:17 +0200
Message-ID: <6ed0b2681002080429m6cdc0bc0u98849ae546c7f6e8@mail.gmail.com>
References: <1265375612-9079-1-git-send-email-notasas@gmail.com>
	<1265378923.3177.11.camel@odin>
	<6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
	<20100205172031.GA31523@rakim.wolfsonmicro.main>
	<6ed0b2681002060933x38009b77r237db131ab172fee@mail.gmail.com>
	<20100207110732.9279b77a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 7053C243B1
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 13:29:18 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 22so24826fge.2
	for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2010 04:29:17 -0800 (PST)
In-Reply-To: <20100207110732.9279b77a.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 7, 2010 at 11:07 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Sat, 6 Feb 2010 19:33:08 +0200
> Grazvydas Ignotas <notasas@gmail.com> wrote:
>
>> It's on powerdown, there is a faint pop. It appears its the amp (final
>> part in the path), I tried to toggle it while playing /dev/zero
>> manually and it always pops on powerdown. On powerup there is a small
>> sound cutoff too, probably because of amp capacitors charging, but we
>> decided to leave it instead of halting every sound playing program
>> until the amp gets ready.
>>
> My side comment for the /dev/zero test. You may hear pops also
> if /dev/zero is played as unsigned 8-bit samples on signed DAC since
> then samples gets converted to maximum negative value.
>
> So there is a difference how the /dev/zero is played. First command
> below produces a pop because it's playing a pop and second produces a
> pop only if HW is producing it.
>
> aplay /dev/zero
> aplay -f S16_LE /dev/zero

I was testing with '-f cd' which should also be signed. Actually doing
just 'aplay /dev/zero' makes matters worse, there is some additional
'squeek' noise audible when I turn the volume up.

On Mon, Feb 8, 2010 at 1:39 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> If this goes off too much you might want to tweak the delay ASoC uses to
> defer power down of DAPM widgets after streams stop.  There's a command
> line option pmdown_time, it really ought to have a sysfs file to tweak
> but there's not been any demand.

Yes we are already using that (set to 1 minute), and the sysfs file
would be useful for us (we have a hack for that in our tree).
