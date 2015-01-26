From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa] Crackling after 6.45 hours
Date: Mon, 26 Jan 2015 13:09:06 +0100
Message-ID: <54C62E62.3060904@metafoo.de>
References: <3427562.sVz54J9OhN@linux-le0l.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-156.synserver.de (smtp-out-156.synserver.de
 [212.40.185.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 32BC5260504
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 13:09:07 +0100 (CET)
In-Reply-To: <3427562.sVz54J9OhN@linux-le0l.site>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "a.renault@kaptalia.com" <a.renault@kaptalia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/23/2015 03:34 PM, a.renault@kaptalia.com wrote:
> Hi everyone,
>
> I currently facing the following issue :
>
> My sound crackling after 6.45 hours of music without reinitialization.
>
> I am using sdl-mixer, sdl and alsa.
>
> I deployed a bug on libsdl at the address :
> https://bugzilla.libsdl.org/show_bug.cgi?id=2794
> And after some works we discover that the snd_pcm_writei answer "-1073741824".
>
> The error code "-1073741824" is not one of -EINTR, -EPIPE, -ESTRPIPE, -EAGAIN.
> So "snd_pcm_recover" does not handle anything.
>
> If you are brave enought please take a look at the link,
>
> Any idea would be greatly appreciated.

Hi,

What's your hardware. Can you run the alsa-info.sh[1] script and send the 
output to the mailing list?

Thanks,
- Lars

[1] http://www.alsa-project.org/main/index.php/Help_To_Debug
