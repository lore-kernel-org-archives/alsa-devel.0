From: Alan Young <consult.awy@gmail.com>
Subject: Re: [PATCH] pcm: rate: Add capability to pass
 configuration node to plugins
Date: Thu, 9 Feb 2017 15:41:04 +0000
Message-ID: <7715a537-722a-be54-6635-d92961b0e617@gmail.com>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC6426680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 16:41:06 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id o16so12338590wra.2
 for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2017 07:41:06 -0800 (PST)
In-Reply-To: <s5hy3xg8zkp.wl-tiwai@suse.de>
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

On 08/02/17 15:36, Takashi Iwai wrote:
> can't change the existing function definition.  This will be broken
> once you mix the old version of plugin with the new system or vice
> versa.
I had concluded that changing the type signature was in this case safe. 
There is no (public) declaration of _snd_pcm_rate_/xxx/_open() function 
type and I think that passing unexpected additional parameters is a 
function is always safe.

However ...
> Alternatively, try to provide another function
> _snd_pcm_rate_xxx_open_conf() or such.  In addition, you should
> provide the old open function as is for now, too.
> Then the rate plugin can try to get and open via snd_dlobj_cache_get()
> for the open_conf at first, then fall back to the old open function.
I like this more. It is cleaner in some ways and avoids the need to bump 
the version number.

I'll work up a revised patch.

Thanks,
Alan.
