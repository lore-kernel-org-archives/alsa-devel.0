From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 10 Jul 2015 08:41:39 -0400
Message-ID: <559FBD83.80003@gmail.com>
References: <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it> <559D3411.6060306@gmail.com>
 <20150708182132.db38656fb4ccc2e38e41aba0@ao2.it> <559D5091.9020802@gmail.com>
 <20150708221745.f72dcbec9c96eb86ce0cbfc2@ao2.it> <559EC436.30900@gmail.com>
 <20150710040623.GY836@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 50DFD260447
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 14:41:22 +0200 (CEST)
Received: by qgef3 with SMTP id f3so78603128qge.0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 05:41:21 -0700 (PDT)
In-Reply-To: <20150710040623.GY836@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

Vinod,

Its a Chinese device with a Z3735F chipset that originally had windows 
8.1 on it.

Thanks-

Tyler

On 07/10/2015 12:06 AM, Vinod Koul wrote:
> On Thu, Jul 09, 2015 at 02:57:58PM -0400, Tyler Yeomans wrote:
>> Antonio/Vinod,
>>
>> I have made the change in the sst-acpi.c file for the atom specific boards.
>> I've attached the dmesg output here with dynamic debug enabled.
>>
>> To clarify-
>>
>> snd-intel-sst-core is loaded
>> FE-BE fix has been applied
>> I'm using the ssp0 firmware.
>>
>> Interrupts are still 0
>>
>> Still no sound.
>>
>> Would leaving the device on and providing remote access (i.e though
>> teamviewer) assist in any way?
> The fw download seems to fail on your device, which can also be due to
> incorrect interrupt mapping...
>
> [   20.386850] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0,
> msg_id:0x1 fw_state 0x3
> [   20.386862] intel_sst_acpi 80860F28:00: fw returned err -16
> [   20.386873] sst-mfld-platform sst-mfld-platform: Enter: enable=1
> port_name=ssp2-port
> [   20.752559] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0,
> msg_id:0x1 fw_state 0x3
> [   20.752570] intel_sst_acpi 80860F28:00: fw returned err -16
> [   21.163378] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0,
> msg_id:0x0 fw_state 0x1
> [   21.163388] intel_sst_acpi 80860F28:00: fw download failed -16
>
> Can you tell me which device you have, what was preinstalled on it
>
