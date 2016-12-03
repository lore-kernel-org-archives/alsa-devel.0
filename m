From: Joseph Wang <joequant@gmail.com>
Subject: Cherry trail and Nau 88l24 codec
Date: Sat, 3 Dec 2016 09:16:38 +0800
Message-ID: <CAPoeEY_Tve2TAgBqY+MqPEUGnbadYHg9Z90DQ=YQumWebfW++A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 467F0265DB7
 for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2016 02:16:40 +0100 (CET)
Received: by mail-qk0-f170.google.com with SMTP id q130so109065596qke.1
 for <alsa-devel@alsa-project.org>; Fri, 02 Dec 2016 17:16:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, KCHSU0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Hi all,

I've been trying to get sound working on my W9S pipo device.  The people at
Nuvoton have been extraordinarily helpful, but now the issue is writing the
machine driver.

My work is at

https://github.com/joequant/nau8824

I've gotten the drivers to load, but getting timeouts with the firmware....

[  102.447840] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[  102.447872] intel_sst_acpi 808622A8:00: fw returned err -16
[  103.471448] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3

and then

[  116.820782] intel_sst_acpi 808622A8:00: fw returned err -16
[  116.938921] intel_sst_acpi 808622A8:00: FW sent error response 0x5000e
[  116.939065] intel_sst_acpi 808622A8:00: FW sent error response 0x5000e
[  116.939579] intel_sst_acpi 808622A8:00: FW sent async error msg:
[  116.939614] (null)00040021 00000000
[  116.939685] (null)00040021 00000000
[  116.953260] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[  116.953704] intel_sst_acpi 808622A8:00: Alloc for str 3 pipe 0xe
[  116.954062] sst-mfld-sst-mfld-platform: SET_SWM cmd max inputs reached

One other path is that ICube has gotten this codec to work on their iwork8
Ultimate android device.  They are required to release the source under
GPL2, but haven't done so, so if all else fails, it will be a matter of
tracking down someone in that company and explaining the issues to them.
Since I'm in Hong Kong, I might just find where the things are
manufactured, and just show up at their office.

But it appears that there are some "magic bits" that are missing.  One
question that I have is what is the proper DAI to use (i.e. PCM or I2S) for
cherry trail.  The second question is that looking at the windows driver
for nau88l24, there appears to be a test mode that runs the driver against
a Realtek rt5645.  Should I assume that this means that the initialization
is similar?

Also I'm quite interested in getting this to work.  The W9S Pipo is a
perfect netbook that has a big screen that is half the weight of my old
laptop.  The big thing is that someone realized that instead of putting in
a SATA hard disk, that they can use an SD card as main storage, and that
cuts down on the weight.
