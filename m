From: Ondrej Zary <linux@rainbow-software.org>
Subject: 7.1 surround channels missing on CS46xx
Date: Thu, 16 May 2013 12:55:26 +0200
Message-ID: <201305161255.26607.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id C3B332654B8
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 12:55:40 +0200 (CEST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hello,
I got a Hercules Fortissimo 7.1 sound card (CS4624 + two CS4294) but 
snd-cs46xx driver supports only 6 channels (front, rear, center/lfe). The 
surround output (7&8) is not supported - as seen in dsp_spos_scb_lib.c:

       case DSP_PCM_S71_CHANNEL:
                /* TODO */
                snd_BUG();
                break;

Tried to add a code for this, mostly copying the center/lfe code but I miss 
some data:
 - which slots (ACOSV_SLVx) should be used (maybe 10 and 12?)
 - what are the channel_disp and fifo_addr values for
   cs46xx_dsp_create_codec_out_scb() function
 - what values should S71_MIXER_SCB_ADDR and S71_CODEC_SCB_ADDR be (maybe
   0x1b0 and 0x1c0?)

-- 
Ondrej Zary
