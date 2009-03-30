From: <olly@funkster.org>
Subject: =?utf-8?q?Non-interleaved_multi-channel_access=2C_wh?=
	=?utf-8?q?at=27s_required=3F_Oxygen_driver=2E=2E=2E?=
Date: Mon, 30 Mar 2009 14:32:03 +0100
Message-ID: <HALMjkatwD43oFLaqSO00000135@hal>
Reply-To: olly@funkster.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mk-outboundfilter-1.mail.uk.tiscali.com
	(mk-outboundfilter-1.mail.uk.tiscali.com [212.74.114.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FAB5103802
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Mar 2009 15:32:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

   Hope this is the right place for this. I'm working on an app that requires non-interleaved access to 6 output channels, but alas the driver for the card that I'm using (Asus Xonar D1, AV100 / C-Media Oxygen chipset) doesn't support the noninterleaved access type, giving "incorrect access type" in response to this command:

if ((err = snd_pcm_hw_params_set_access(playback_handle, hw_params, SND_PCM_ACCESS_RW_NONINTERLEAVED)) < 0)
{
    fprintf(stderr, "cannot set access type (%s)\n", snd_strerror (err));
    return false;
}

   In a bout of optimism, I simply added the SNDRV_PCM_INFO_NONINTERLEAVED flag to the .info part of the snd_pcm_hardware struct that's defined for the card in oxygen_pcm.c and recompiled the kernel, not expecting it to really work.

   To my surprise, it does work! But, only for the "default" card and with two channels. If I try to use any of the multi-channel devices (e.g. front, surround51) then each channel appears to alternate round the buffers for all the channels.

   So... how do I find out if this is a limitation of the hardware? Can I do anything to the multi-channel part of the driver to make non-interleaved access work correctly? Or is there some clever use of the .asoundrc that can make it do what I need to?

Many thanks in advance for any help,
--
Oliver Stephenson
http://www.funkster.org/


_______________________________________
Sent using funkster.org webmail service
