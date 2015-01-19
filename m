From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Strange bug in alsa-lib
Date: Mon, 19 Jan 2015 09:23:02 +0100
Message-ID: <54BCBEE6.6040000@canonical.com>
References: <54BC23C9.8000001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D27E26053E
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 09:23:05 +0100 (CET)
In-Reply-To: <54BC23C9.8000001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: plcmn <daberende@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

This is probably a driver/hardware problem. From the information you 
provided, the computer lost contact with the HDA analog codec (this is bad).

I had a similar problem a year ago, and after some trial-and-error, 
after disabling MSI I could no longer reproduce the problem.

You can edit /etc/modprobe.d/alsa-base.conf and add

options snd-hda-intel enable_msi=0

and then reboot. Does this help?

On 2015-01-18 22:21, plcmn wrote:
> Greetings everyone!
>
> I'm sorry in advance for my poor English.
> Unfortunately your bugtracker is down so I've had to send this bug
> report (or description, huh) here.
> Alsa information about my system is in the attachments.
>
> I've came across this bug a few days ago, it appeared since I've
> installed alsa. Everytime when I try to quickly change the volume on
> Master channel the sound brakes: alsamixer hangs up and some music
> players (for example, Music on Console) play music by fits and starts
> (it's similar to watching hd video on a slow connection). Some music
> players, for example DeadBeeF, or browsers, such as Chromium work quite
> normal. I've searched forums, but I didn't come across anyone with a
> similar problem. So, I've decided to do a little research to find out
> what caused the problems. I've started with a simple script:
>
> plcmn@equestria:~$ cat test.sh
> export i=0
> while [ $i -lt 80 ]
> do
>    amixer set Master $i%
>    let i=$(($i+1))
> done
>
> Here are the results of the execution before the bug appears:
>
> plcmn@equestria:~$ time ./test.sh
> real    0m0.743s
> user    0m0.350s
> sys    0m0.203s
>
> And this how it looks like when the bug comes out (I've just launched
> this script two times in a row):
>
> plcmn@equestria~$ time test.sh
>
> real    4m41.763s
> user    0m0.607s
> sys    0m12.037s
>
> That looked really weird, so I've tried to figure out what caused the
> problem. Checking the source with cppcheck didn't gave any results,
> except some memory leaks (like [src/rawmidi/rawmidi_hw.c:304]: (error)
> Memory leak: hw), but none of them referred to my problem. So I've
> digged into the code and found out the line that caused the error:
>
>   ---
>
>  From src/control/control_hw.c:
> 193 if (ioctl(hw->fd, SNDRV_CTL_IOCTL_ELEM_WRITE, control) < 0) {
>
> ---
>
> I'm a dummy in system programming, so I can't exactly tell what's the
> problem with this line (I know ioctl's purpose, but I don't what to do
> next -- a mess of macros and structures were hard for understanding, so
> I stopped at this point). The delay measured by clock() from time.h was
> about 0.18 ms here.
>
> Here is gdb's output for arguments passed to the problematic function:
>
> Breakpoint 2, snd_ctl_hw_elem_write (handle=<optimized out>,
> control=0x7fffffffd9e0) at control_hw.c:193
> (gdb) n
> 194        snd_ctl_hw_t *hw = handle->private_data;
> (gdb) p handle
> $2 = <optimized out>
> (gdb) p control
> $3 = (snd_ctl_elem_value_t *) 0x7fffffffd9e0
> (gdb) p control->id
> $4 = {numid = 16, iface = 2, device = 0, subdevice = 0,
>        name = "Master Playback Volume", '\000' <repeats 21 times>, index
> = 0}
> (gdb) p control->indirect
> $5 = 0
> (gdb) p control->reserved
> $6 = '\000' <repeats 111 times>
> (gdb) p control->tstamp
> $7 = {tv_sec = 0, tv_nsec = 0}
> (gdb) p control->value
> $8 = {integer = {value = {70, 0 <repeats 127 times>}, value_ptr = 0x46},
> integer64 = {value = {70, 0 <repeats 63 times>}, value_ptr = 0x46},
> enumerated = {item = {70, 0 <repeats 127 times>},
>        item_ptr = 0x46}, bytes = {data = "F", '\000' <repeats 510 times>,
>        data_ptr = 0x46 <error: Cannot access memory at address 0x46>},
> iec958 = {status = "F", '\000' <repeats 22 times>,
>        subcode = '\000' <repeats 146 times>, pad = 0 '\000',
> dig_subframe = "\000\000\000"}}
>
> For some reason this function is called twice, the second call doesn't
> cause such a delay.
>
> I can provide any information you'll need.
>
> I hope that my report will be useful.
> Sorry again for my poor English and sending a bug report to dev mail lists.
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
