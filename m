From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Tue, 3 Mar 2015 15:16:21 +0100
Message-ID: <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id A5FBC2614C1
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:16:23 +0100 (CET)
In-Reply-To: <20150223183913.fb262011d6300425da7f34be@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Feb 2015 18:39:13 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> Hi,
> 
> I am trying to get the Intel SST driver working on a Teclast X98 Air 3G
> [1], it's a Bay Trail tablet. The tests below have been made with
> 4.0.0-rc1 and the firmware files from
> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/intel
> 

Hi, has anyone had a chance to take a look at my previous message?

[...]
> Last question, what is the difference between having the device detected
> by sound/soc/intel/sst-acpi.c (like in my case) opposed to
> sound/soc/intel/sst/sst_acpi.c? I can see the 80860F28 id in both the
> files but they seem to load different firmwares.
>

Another thing I noticed is that the Android driver for the rt5640 codec
defines some controls which are not in the mainline driver:

  OUT MIXR BST3 Switch
  OUT MIXL BST3 Switch
  RECMIXR BST3 Switch
  RECMIXL BST3 Switch
  IN1 Mode Control
  IN2 Mode Control

I tried to add these copying from some Android kernel found on-line[1]
and set the value to the ones used on Android but they don't seem to
make a difference.

> Any idea of what is missing?
> It's the DSDT which still needs adjusting, or are some changes needed
> (also) in the kernel driver?
> 

Thanks,
   Antonio

[1] https://github.com/ZenfoneArea/android_kernel_asus_zenfone5

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
