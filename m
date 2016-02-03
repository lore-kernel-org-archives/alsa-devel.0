From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: out-of-bounds write in snd_rawmidi_kernel_write1
Date: Wed, 3 Feb 2016 14:25:23 +0100
Message-ID: <CACT4Y+Zy8Ky0dBLvPWTCJ=F8H4kvNBXxvYZXB09Hwe8wGmYbkg@mail.gmail.com>
References: <CACT4Y+b-dCmNf1GpgPKfDO0ih+uZCL2JV4__j-r1kdhPLSgQCQ@mail.gmail.com>
 <s5hpowe2l2l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hpowe2l2l.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 3, 2016 at 10:35 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 03 Feb 2016 09:57:50 +0100,
> Dmitry Vyukov wrote:
>>
>> Hello,
>>
>> The following program triggers an out-of-bounds write in
>> snd_rawmidi_kernel_write1 (run in parallel loop). It seems to try to
>> copy -1 bytes (aka 4GB) from user space into kernel smashing all on
>> its way.
>
> What card is /dev/midi3?  Please check /proc/asound/cards.
> Is it MTPAV?

Yes, it was MTPAV. There is only generic code in the stack traces, so
I though it may be a generic issue. Though, of course, the driver
could mess things already.
I've dropped CONFIG_SND_MTPAV now.
