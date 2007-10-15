From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: intel-hda patch for sigmatel codec volume knob
Date: Mon, 15 Oct 2007 12:02:21 +0200
Message-ID: <200710151202.21340.maximlevitsky@gmail.com>
References: <1192433370.10218.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 333CC24600
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Oct 2007 12:02:45 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so72809ana
	for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2007 03:02:44 -0700 (PDT)
In-Reply-To: <1192433370.10218.9.camel@localhost.localdomain>
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, zhejiang <zhe.jiang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Monday 15 October 2007 09:29:30 zhejiang wrote:
> Hi,
> 
> I found that STAC_VOLKNOB hardwired the KNOB nid to 0x24.
> It is okay for stac9205 and stac927x.
> But the VolumeKnob nid of stac9220-9221 is 0x16.
> 
> 
> diff -Nur a/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
> b/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
> --- a/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
> 2007-09-21 16:41:28.000000000 +0800
> +++ b/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
> 2007-10-15 15:13:14.000000000 +0800
> @@ -351,7 +351,7 @@


Hi,

Thank you very much, I am the author of patch that added the volume knob
Although I checked carefully the datasheets I missed that one.

Thanks a lot.

	Maxim Levitsky
