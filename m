From: Bruno Wolff III <bruno@wolff.to>
Subject: Re: Logitech USB headset not working in 3.6-rc3
Date: Sat, 25 Aug 2012 07:16:21 -0500
Message-ID: <20120825121621.GA24462@wolff.to>
References: <20120824190808.GC20043@zod.bos.redhat.com>
 <5038007E.5060505@gmail.com>
 <20120825111749.GA17048@wolff.to>
 <20120825115423.GA14327@wolff.to>
 <5038BEEB.6090303@gmail.com>
 <20120825120740.GA19539@wolff.to>
 <20120825121326.GE20043@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120825121326.GE20043@zod.bos.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: Daniel Mack <zonque@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 25, 2012 at 08:13:27 -0400,
   Josh Boyer <jwboyer@redhat.com> wrote:
>On Sat, Aug 25, 2012 at 07:07:40AM -0500, Bruno Wolff III wrote:
>> On Sat, Aug 25, 2012 at 14:02:51 +0200,
>>   Daniel Mack <zonque@gmail.com> wrote:
>> >
>> >Can you revert commit e9ba389c5 ("ALSA: usb-audio: Fix
>> >scheduling-while-atomic bug in PCM capture stream") and see if that
>>
>> I can try that, but it takes a long time to build a new kernel on my
>> old hardware.
>
>I started a scratch build of a kernel with that patch reverted (via
>patch -R).  You'll find it here when it finishes:
>
>http://koji.fedoraproject.org/koji/taskinfo?taskID=4421817
>
>josh

I'll test it when it finishes. Thanks. It takes me a long time to build 
kernels locally, and I wasn't sure how to do a scratch build on koji without 
committing stuff remotely.
