From: Avi Kivity <avi@redhat.com>
Subject: Re: Wierd hack to sound/pci/intel8x0.c
Date: Sun, 06 Nov 2011 18:31:42 +0200
Message-ID: <4EB6B66E.4050408@redhat.com>
References: <4EB69EDA.5000901@redhat.com> <4EB6B285.9050509@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4EB6B285.9050509@parallels.com>
Sender: kvm-owner@vger.kernel.org
To: "Denis V. Lunev" <den@parallels.com>
Cc: Konstantin Ozerkov <kozerkov@parallels.com>, "Denis V. Lunev" <den@openvz.org>, Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, KVM list <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-Id: alsa-devel@alsa-project.org

On 11/06/2011 06:15 PM, Denis V. Lunev wrote:
> On 11/6/11 6:51 PM, Avi Kivity wrote:
>> The recently merged 228cf79376f1 ("ALSA: intel8x0: Improve performance
>> in virtual environment") is hacky and somewhat wrong.
>>
>> First, the detection code
>>
>> +       if (inside_vm<  0) {
>> +               /* detect KVM and Parallels virtual environments */
>> +               inside_vm = kvm_para_available();
>> +#if defined(__i386__) || defined(__x86_64__)
>> +               inside_vm = inside_vm ||
>> boot_cpu_has(X86_FEATURE_HYPERVISOR);
>> +#endif
>> +       }
>> +
>>
>> is incorrect.  It detects that you're running in a guest, but that
>> doesn't imply that the device you're accessing is emulated.  It may be a
>> host device assigned to the guest; presumably the optimization you apply
>> doesn't work for real devices.
>>
>> Second, the optimization itself looks fishy:
>>
>>          spin_lock(&chip->reg_lock);
>>          do {
>>                  civ = igetbyte(chip, ichdev->reg_offset +
>> ICH_REG_OFF_CIV);
>>                  ptr1 = igetword(chip, ichdev->reg_offset +
>> ichdev->roff_picb);
>>                  position = ichdev->position;
>>                  if (ptr1 == 0) {
>>                          udelay(10);
>>                          continue;
>>                  }
>> -               if (civ == igetbyte(chip, ichdev->reg_offset +
>> ICH_REG_OFF_CIV)&&
>> -                   ptr1 == igetword(chip, ichdev->reg_offset +
>> ichdev->roff_picb))
>> +               if (civ != igetbyte(chip, ichdev->reg_offset +
>> ICH_REG_OFF_CIV))
>> +                       continue;
>> +               if (chip->inside_vm)
>> +                       break;
>> +               if (ptr1 == igetword(chip, ichdev->reg_offset +
>> ichdev->roff_picb))
>>                          break;
>>          } while (timeout--);
>>
>>
>> Why is the emulated device timing out?  Can't the emulation be fixed to
>> behave like real hardware?
>>
>> Last, please copy kvm@vger.kernel.org on such issues.
>>
> The problem is that emulation can not be fixed.
>
> How this is working for real hardware? You get data from real sound
> card register.
> The scheduling is off at the moment thus you can not be re-scheduled.
>
> In the virtual environment the situation is different. Any IO
> emulation is expensive.
> The processor is switched from guest to hypervisor and further to
> emulation process
> takes a lot of time.  This time is enough to obtain different value on
> next register read.
> That's why this code is really timed out. Please also note that host
> scheduler also
> plays his games and could schedule out VCPU thread.
>

Note on kvm this is rare, since the guest thread and the emulator thread
are the same.

> The problem could be potentially fixed reducing precision of PICB
> emulation,
> but this results in lower sound quality.
>
> This kludge has been written this way in order not to break legacy
> card for which we
> do not have an access. The code reading PICB/CIV registers second time
> was added
> to fix issues on unknown for now platform and it looks not possible
> how to find/test
> against this platform now. We have checked Windows drivers written by
> Intel/AMD
> (32/64 bit) and MacOS ones. There is no second reading of CIV/PICB
> inside. We
> hope that this is relay needed only for some rare hadware devices.
>

Ok, so if I understand correctly, this loop is a hack for broken
hardware, and this patch basically unhacks it back, assuming that the
emulated (or assigned) hardware is not broken.

> The only thing we can is to improve detection code. Suggestions are
> welcome.

I think it's fine to assume that you're not assigning a 2004 era sound
card to a guest.  So I think the code is fine as it is, and can only
suggest to add a comment explaining the mess.

Thanks for explaining.

-- 
error compiling committee.c: too many arguments to function

