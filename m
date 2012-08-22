From: Ian Minett <ian_minett@creativelabs.com>
Subject: Re: [PATCHv2.1-CA0132 HDA Codec 1/1] Draft DSP loader
	update #2
Date: Tue, 21 Aug 2012 18:36:01 -0700
Message-ID: <OFC7C35A7D.8D857BE7-ON88257A62.0004AEB8-88257A62.0008CAB7@cli.creative.com>
References: <s5hobmh9a1f.wl%tiwai@suse.de>	<1345009806-3293-1-git-send-email-ian_minett@creativelabs.com>
 <s5h628kocq9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound2.cli.creative.com
 (smtp-outbound2.cli.creative.com [124.246.64.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CEF7265F16
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 03:36:10 +0200 (CEST)
In-Reply-To: <s5h628kocq9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org






>There shouldn't be any addition of controls, etc, at this point.
>Just do load the firmware.  This is the very first start.
>
>I can help debugging or give review / advise.  But obviously you are
>at the better position start writing it since you have the test
>hardware and the firmware data, both of which are missing for other
>developers (including me).
>
>Once when a draft patch is ready or you face to a problem, let me
>know.

Ok, thanks.
We do seem to be having problems in the DSP load prepare function:

void *(*load_dsp_prepare)(struct hda_codec *codec, unsigned int format,
                          unsigned int byte_size);

This is the place where the buffer gets allocated, and BDL and DMA set up, and the
pointer returned.
Is there any sample code or other info you could provide, to give us a better idea
of how the function and these actions should be implemented?

Thanks very much,
- Ian
