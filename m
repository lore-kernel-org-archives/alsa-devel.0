From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Fix debugfs_create_dir's error
	checking	method for sound/soc/
Date: Fri, 17 Oct 2008 16:28:36 +0100
Message-ID: <20081017152833.GI2546@sirena.org.uk>
References: <48F88D77.2080106@cn.fujitsu.com>
	<20081017132340.GF2546@sirena.org.uk>
	<s5hfxmvw8lq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D8A88243E0
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 17:28:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfxmvw8lq.wl%tiwai@suse.de>
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
Cc: Zhaolei <zhaolei@cn.fujitsu.com>, lrg@slimlogic.co.uk, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2008 at 05:21:21PM +0200, Takashi Iwai wrote:

> This looks like a design.  In linux/debugfs.h:

Yeah, so my grovelling through the code after I wrote that e-mail
showed.

> /* 
>  * We do not return NULL from these functions if CONFIG_DEBUG_FS is not enabled
>  * so users have a chance to detect if there was a real error or not.  We don't
>  * want to duplicate the design decision mistakes of procfs and devfs again.
>  */

> Though, I agree that the detailed error information is lost by
> returning NULL...

Yes, not to mention the fact that using both error reporting interfaces
makes writing client code more error prone.  Looking at the users most
seem to only check one kind of error code is returned.  

For ASoC checking only for null would actually be good enough - even if
-ENODEV is returned we only ever pass the pointers into other debugfs
functions so the fact that the pointer is bogus makes no odds, it'll
never actually be dereferenced.
