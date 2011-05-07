From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: aplay throws error
Date: Sat, 7 May 2011 22:29:34 +0800
Message-ID: <20110507142934.GD13216@qtel.sh.intel.com>
References: <4DC4F447.4040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B011424448
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 16:30:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC4F447.4040607@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: preetam <preetamsashankreddy@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, May 07, 2011 at 03:27:03PM +0800, preetam wrote:
> Hai,
> 
> My aplay throws the following error:
> 
> Playing WAVE 'Linkin Park - New divide.wav' : Signed 16 bit Little 
> Endian, Rate 44100 Hz, Stereo
> aplay: aplay.c:1029: set_params: Assertion `err >= 0' failed.

Hi,

What's your version of alsa-utils?
I don't see the assert(err >= 0) on line 1029 on the latest repository
code.

Well, if this utilizes your newly written driver, I would suggest you
insert some logs in your hw_params callback in driver. It might actually
be your driver's mis-behavour.

I'm not an expert on alsa, so it's just my 2 cents...

> Aborted by signal Aborted...
> 
> 
> I am using a pandaboard. Kernel is 2.6.35 from omap tree L27.11.1.
> 
> I am new to alsa and I have written an soc driver for this.
> can anyone help me.
> 
> I can only trace the function calls to alloca. I am blank from here on.
> 
> Regards,
> Preetam
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
guanqun
