From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: at91 SoC Modifications
Date: Mon, 25 Jun 2007 15:09:56 -0500
Message-ID: <61c0054e0706251309lf60afabi86ab192e10a0635@mail.gmail.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E80B243F9
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 22:10:00 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so1349994uge
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 13:09:59 -0700 (PDT)
In-Reply-To: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello all:

I have been struggling to determine why the sync line (TF0) behaves so
strangely when in capture mode yet acts fine in playback mode. So far, no
real clues. However, I do have a few questions. I have DATADEF set for TD0
set to 1. However, at the end of a playback it pulls to zero. Any clue why
this might be happening?

Also, in the machine code, I set up some test code to printk back the gpio
registers:

the code for the gpio is given as

#define AT91_PIO_TK0    (1 << (AT91_PIN_PB16 - PIN_BASE) % 32)
#define AT91_PIO_TF0    (1 << (AT91_PIN_PB17 - PIN_BASE) % 32)
#define AT91_PIO_TD0    (1 << (AT91_PIN_PB18 - PIN_BASE) % 32)
#define AT91_PIO_RD0    (1 << (AT91_PIN_PB19 - PIN_BASE) % 32)
#define AT91_PIO_RK0    (1 << (AT91_PIN_PB20 - PIN_BASE) % 32)
#define AT91_PIO_RF0    (1 << (AT91_PIN_PB21 - PIN_BASE) % 32)
.
.
.
    ssc_pio_lines = AT91_PIO_TF0 | AT91_PIO_TK0 | AT91_PIO_TD0
            | AT91_PIO_RD0 /*| AT91_PIO_RK0 | AT91_PIO_RF0*/ ;

        printk("SSC PIO LINES is 0x%x\n",ssc_pio_lines);
    /* Reset all PIO registers and assign lines to peripheral A */
     at91_sys_write(AT91_PIOB + PIO_PDR,  ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_ODR,  ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_IFDR, ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_CODR, ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_IDR,  ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_MDDR, ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_PUDR, ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_ASR,  ssc_pio_lines);
     at91_sys_write(AT91_PIOB + PIO_OWDR, ssc_pio_lines);

        /*TEST CODE*/
        printk("PIOB-PDR is set to %d\n",at91_sys_read(AT91_PIOB +
PIO_PDR));
     printk("PIOB-ODR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_ODR));
     printk("PIOB-IFDR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_IFDR));
     printk("PIOB-CODR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_CODR));
     printk("PIOB-IRD is set to %d\n",at91_sys_read(AT91_PIOB + PIO_IDR));
     printk("PIOB-MDDR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_MDDR));
     printk("PIOB-PUDR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_PUDR));
     printk("PIOB-ASR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_ASR));
     printk("PIOB-OWDR is set to %d\n",at91_sys_read(AT91_PIOB + PIO_OWDR));
        /*END OF TEST CODE*/


and the result at boot is:

AT91SAM9260EK W6811 Driver <1>
w6811: W6811 PCM SoC Audio 0.1
asoc: W6811 <-> at91-ssc0 mapping ok
SSC PIO LINES is 0xf0000
PIOB-PDR is set to 0
PIOB-ODR is set to 0
PIOB-IFDR is set to 0
PIOB-CODR is set to 0
PIOB-IRD is set to 0
PIOB-MDDR is set to 0
PIOB-PUDR is set to 0
PIOB-ASR is set to 0
PIOB-OWDR is set to 0

...why are all the registers set to 0?

I may have to try separating TF0/RF0 and TK0/RK0....but should not have to I
do not think.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
