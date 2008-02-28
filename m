From: Matt Whitlock <matt@whitlock.name>
Subject: Re: How to set idle S/PDIF sample rate?
Date: Thu, 28 Feb 2008 16:12:10 -0500
Message-ID: <200802281612.11099.matt@whitlock.name>
References: <200802222234.22975.matt@whitlock.name>
	<200802261725.35575.matt@whitlock.name>
	<s5h8x15s3vm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 21DAB10387E
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 22:12:15 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so777039ana.80
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 13:12:14 -0800 (PST)
In-Reply-To: <s5h8x15s3vm.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday, 28 February 2008 6:43:25 am Takashi Iwai wrote:
> The driver code resets the format verb of the relevant widgets at
> closing streams.  This verb contains the sample rate, too.  Maybe
> keeping this would prevent the reset.
> 
> The below is a test patch.  Give it a try.

Wow, fantastic.  I will give this patch a try.  I'll have to rebuild my kernel to disable the in-kernel ALSA code and build the ALSA module separately from the latest sources, but if this patch fixes things, that would be worth the effort.  I'll get back to you.  Thanks.

-Matt
