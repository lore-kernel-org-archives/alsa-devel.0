From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: +
	v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch added to -mm
	tree
Date: Mon, 07 Nov 2005 15:19:29 -0500
Message-ID: <1131394769.8383.94.camel@mindpipe>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org> <1131301995.13599.5.camel@mindpipe>
	 <1131344803.10094.8.camel@localhost> <1131377615.8383.9.camel@mindpipe>
	 <s5h4q6opi5t.wl%tiwai@suse.de>  <20051107114843.0a476d90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965174AbVKGUVQ@vger.kernel.org>
In-Reply-To: <20051107114843.0a476d90.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, mchehab@brturbo.com.br, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, nshmyrev@yandex.ru, v4l@cerqueira.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-07 at 11:48 -0800, Andrew Morton wrote:
> Despite all that, I am inclined to merge this patch into 2.6.15.
> Because it's in the middle of a 192-patch series and we do need to get
> the v4l tree synced up.
> 

I think starting the DMA in the prepare callbacks is a major problem.
It should be easy to fix though.

Lee
