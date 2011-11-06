From: Avi Kivity <avi@redhat.com>
Subject: Wierd hack to sound/pci/intel8x0.c
Date: Sun, 06 Nov 2011 16:51:06 +0200
Message-ID: <4EB69EDA.5000901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: Konstantin Ozerkov <kozerkov@parallels.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, KVM list <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-Id: alsa-devel@alsa-project.org

The recently merged 228cf79376f1 ("ALSA: intel8x0: Improve performance
in virtual environment") is hacky and somewhat wrong.

First, the detection code

+       if (inside_vm < 0) {
+               /* detect KVM and Parallels virtual environments */
+               inside_vm = kvm_para_available();
+#if defined(__i386__) || defined(__x86_64__)
+               inside_vm = inside_vm ||
boot_cpu_has(X86_FEATURE_HYPERVISOR);
+#endif
+       }
+
 
is incorrect.  It detects that you're running in a guest, but that
doesn't imply that the device you're accessing is emulated.  It may be a
host device assigned to the guest; presumably the optimization you apply
doesn't work for real devices.

Second, the optimization itself looks fishy:

        spin_lock(&chip->reg_lock);
        do {
                civ = igetbyte(chip, ichdev->reg_offset + ICH_REG_OFF_CIV);
                ptr1 = igetword(chip, ichdev->reg_offset +
ichdev->roff_picb);
                position = ichdev->position;
                if (ptr1 == 0) {
                        udelay(10);
                        continue;
                }
-               if (civ == igetbyte(chip, ichdev->reg_offset +
ICH_REG_OFF_CIV) &&
-                   ptr1 == igetword(chip, ichdev->reg_offset +
ichdev->roff_picb))
+               if (civ != igetbyte(chip, ichdev->reg_offset +
ICH_REG_OFF_CIV))
+                       continue;
+               if (chip->inside_vm)
+                       break;
+               if (ptr1 == igetword(chip, ichdev->reg_offset +
ichdev->roff_picb))
                        break;
        } while (timeout--);


Why is the emulated device timing out?  Can't the emulation be fixed to
behave like real hardware?

Last, please copy kvm@vger.kernel.org on such issues.

-- 
error compiling committee.c: too many arguments to function

