From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] pcm_lib.c: Fixed inaccurate calculation of
 hw_ptr_interrupt in snd_pcm_update_hw_ptr_interrupt function
Date: Wed, 19 Aug 2009 13:01:50 +0000
Message-ID: <1250686910.2060.20.camel@sl>
References: <1250677339.3516.17.camel@shinel> <s5hd46scctf.wl%tiwai@suse.de>
	<1250679571.500.20.camel@shinel> <s5h7hx0c8l2.wl%tiwai@suse.de>
	<1250686106.2060.16.camel@sl>  <s5hocqcarrx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg73.qq.com (smtpbg73.qq.com [119.147.10.232])
	by alsa0.perex.cz (Postfix) with SMTP id D74372441D
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 15:02:07 +0200 (CEST)
In-Reply-To: <s5hocqcarrx.wl%tiwai@suse.de>
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

On Wed, 2009-08-19 at 14:53 +0200, Takashi Iwai wrote:
> 
> It is hardware dependent, i.e. how the irq is generated.
> If the irq is generated in a way like timer, the period size doesn't
> have to be aligned with the buffer size.  But your case doesn't look
> like that.
> 
> 
> Takashi
> 

Thanks, I'll find a way to fix this bug for the AsoC s3c24xx platform.
