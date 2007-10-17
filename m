From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: hda-intel: no soundcard with current linus' git
	tree
Date: Wed, 17 Oct 2007 04:47:21 +0200
Message-ID: <200710170447.21556.maximlevitsky@gmail.com>
References: <471538C2.80806@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id B72812462F
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 04:47:53 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so199221ugf
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 19:47:53 -0700 (PDT)
In-Reply-To: <471538C2.80806@m3y3r.de>
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 17 October 2007 00:18:42 Thomas Meyer wrote:
> $ dmesg
> 
> [schnipp]
> 
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
> PCI: Enabling bus mastering for device 0000:00:1b.0
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> hda_codec: STAC922x, Apple subsys_id=106b0200
> ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> HDA Intel: probe of 0000:00:1b.0 failed with error -16
> 
> [schnipp]
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Please bisect this (the alsa merge happened just short time ago)
Which kernel did work?

Best regards,
	Maxim Levitsky
