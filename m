From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] snd_usb_caiaq: use likely()/unlikely()
Date: Sat, 12 Apr 2008 23:21:27 +0300
Message-ID: <20080412202127.GB8849@cs181133002.pp.htv.fi>
References: <20080412201331.GA13041@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A2842445D
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 22:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080412201331.GA13041@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 12, 2008 at 10:13:31PM +0200, Daniel Mack wrote:
> Use likely() and unlikely() in code which is called regularily.
>...

Does it bring any measurable advantage?

Otherwise it's usually better to let the compiler decide how to optimize 
the code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
