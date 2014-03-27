From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: set up user bits for
	S/PDIF mode
Date: Thu, 27 Mar 2014 10:31:26 +0100
Message-ID: <5333EFEE.5090000@gmail.com>
References: <1395846273-26025-1-git-send-email-zonque@gmail.com>
 <5333DE63.1010205@ti.com> <5333E3BE.80403@gmail.com>
 <5333EB16.2080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A7B4F261717
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 10:31:41 +0100 (CET)
Received: by mail-bk0-f49.google.com with SMTP id my13so734343bkb.36
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 02:31:41 -0700 (PDT)
In-Reply-To: <5333EB16.2080603@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/27/2014 10:10 AM, Peter Ujfalusi wrote:
> On 03/27/2014 10:39 AM, Daniel Mack wrote:

>> No, these defines are mapped on to 32-bit values, as seen in
>> include/sound/asounddef.h. Over all 6 registers, 192 bits can be stored,
>> which is the full length of channel status bits. Hence, they really need
>> an individual mcasp_set_reg() each.
> 
> I don't think they are mapped for the 32bit:
> #define IEC958_AES0_CON_NOT_COPYRIGHT   (1<<2)
> 
> #define IEC958_AES1_CON_DIGDIGCONV_ID   0x02
> #define IEC958_AES1_CON_PCM_CODER       (IEC958_AES1_CON_DIGDIGCONV_ID|0x00)
> 
> #define IEC958_AES3_CON_FS_48000        (2<<0)  /* 48kHz */
> #define IEC958_AES3_CON_FS_32000        (3<<0)  /* 32kHz */
> #define IEC958_AES3_CON_FS_22050        (4<<0)  /* 22.05kHz */
> #define IEC958_AES3_CON_FS_24000        (6<<0)  /* 24kHz */

Hmm, that's odd. What about this one then, which definitely needs a
larger type than uint16?

#define IEC958_AES4_CON_ORIGFS_44100	(15<<4)	/* 44.1kHz */

I considered DITCSRA0 to DITCSRA5 to carry 6 32 bit values, which map to
the values defined as IEC958_AESX*.

> From the AES3 spec (byte numbers are 1 based while bit numbers are 0 based for
> some reason in the specs):
> Copyright bit is on Byte1's bit 2

"Byte 1" is the at index 0, right?

#define IEC958_AES0_CON_NOT_COPYRIGHT	(1<<2)

> Byte2 has the category code
> and Byte4's 0-3 bits for the sampling frequency.

#define IEC958_AES3_CON_FS_44100	(0<<0)
...

You're right that my register address calculation has to go in 32bit
(DAVINCI_MCASP_DITCSRA_REG + 4, DAVINCI_MCASP_DITCSRA_REG + 8, ...), but
I still don't think the u8-mapping is correct.

I'm confused. :)


Daniel
