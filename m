From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [PATCH] alsa-lib: Add sys/types.h to include list
Date: Tue, 12 Feb 2013 11:21:06 +0200
Message-ID: <1360660866.18048.14.camel@laptop>
References: <1360659971-3852-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 10FAD260317
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 10:21:09 +0100 (CET)
In-Reply-To: <1360659971-3852-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, 1109298@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-02-12 at 10:06 +0100, David Henningsson wrote:
> This is needed by snd_pcm_format_silence* functions which
> return u_int*_t. It was discovered while trying to compile ALSA
> programs with eglibc 2.17.
> 
> Credits to Richard Shaw, Gary Buhrmaster, Matthieu Baerts and
>  Adam Conrad for this fix.
> 
> BugLink: https://bugs.launchpad.net/bugs/1109298
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=885306
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>  include/asoundlib-head.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asoundlib-head.h b/include/asoundlib-head.h
> index 20c8a68..6edbab0 100644
> --- a/include/asoundlib-head.h
> +++ b/include/asoundlib-head.h
> @@ -31,6 +31,7 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/types.h>

int*_t and uint*_t (not u_int*_t) are standard in C99, and they are
available in stdint.h or inttypes.h (both work, inttypes.h contains also
the PRI* constants for the corresponding printf() format specifiers).
Perhaps it would be better to use one of those headers instead? That
would require converting u_int*_t usage to uint*_t, though, so it would
take some extra work...

-- 
Tanu
