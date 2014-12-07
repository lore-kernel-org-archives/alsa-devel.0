From: Clemens Ladisch <clemens@ladisch.de>
Subject: endianness problems in fireworks/bebob_maudio
Date: Sun, 07 Dec 2014 22:24:02 +0100
Message-ID: <5484C572.7040606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A82C02606B5
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 22:24:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

sparse complains:

sound/firewire/fireworks/fireworks_transaction.c:127:18: warning: restricted __be32 degrades to integer

        t = (struct snd_efw_transaction *)data;
        length = min_t(size_t, t->length * sizeof(t->length), length);

't->length' is still a big-endian value.  This means that the driver
ends up always using 'length'.


sound/firewire/bebob/bebob_maudio.c:100:17: warning: incorrect type in initializer (different base types)
sound/firewire/bebob/bebob_maudio.c:100:17:    expected restricted __be32
sound/firewire/bebob/bebob_maudio.c:100:17:    got int

        __be32 cues[3] = {
                MAUDIO_BOOTLOADER_CUE1,
                MAUDIO_BOOTLOADER_CUE2,
                MAUDIO_BOOTLOADER_CUE3
        };

        rcode = fw_run_transaction(device->card, TCODE_WRITE_BLOCK_REQUEST,
                                   device->node_id, device->generation,
                                   device->max_speed, BEBOB_ADDR_REG_REQ,
                                   cues, sizeof(cues));

The three MAUDIO_BOOTLOADER_CUEx values will end up as a different byte
sequence on big-endian machines.  The simplest way to have these twelve
bytes unchanged on the bus is to have a twelve-byte array in the driver.


Regards,
Clemens
