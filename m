From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [2.6 patch] OSS gameport fixes
Date: Thu, 10 Mar 2005 10:36:57 -0500
Message-ID: <d120d5000503100736212a9c87@mail.gmail.com>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	 <200503070941.59365.petkov@uni-muenster.de>
	 <20050307215206.GH3170@stusta.de>
	 <d120d50005030714126e345fe2@mail.gmail.com>
	 <20050307230633.GJ3170@stusta.de> <20050309113217.GB21688@stusta.de>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.202])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E52F41B2
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 16:36:58 +0100 (MET)
Received: by rproxy.gmail.com with SMTP id r35so581399rna
        for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 07:36:57 -0800 (PST)
In-Reply-To: <20050309113217.GB21688@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Mar 2005 12:32:17 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch adds dummy gameport_register_port, gameport_unregister_port
> and gameport_set_phys functions to gameport.h for the case when a driver
> can't use gameport.
> 
> This fixes the compilation of some OSS drivers with GAMEPORT=n without
> the need to #if inside every single driver.
> 
> This patch also removes the non-working and now obsolete SOUND_GAMEPORT.
> 
> This patch is also an alternative solution for ALSA drivers with similar
> problems (but #if's inside the drivers might have the advantage of
> saving some more bytes of gameport is not available).
> 
> The only user-visible change is that for GAMEPORT=m the affected OSS
> drivers are now allowed to be built statically (but they won't have
> gameport support).
> 

Hi Adrian,

I have somewhat mixed feeling about the patch. Some solutions is
definitely needed but I don't like allocating memory that will never
be used. I think I would perfer #ifdefing gameport support is OSS
modules, _if_ #ifdefs are out of line and not in the middle of code
path.

I'll let Vojtech decide which way he wants to go - he could probably
apply the patch and then we could convert drivers one by one and kill
the stubs later.

-- 
Dmitry


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
