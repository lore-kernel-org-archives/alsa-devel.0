From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Drop 2.2/2.4 kernel support in alsa-driver build?
Date: Tue, 12 Jul 2011 18:51:57 +0200
Message-ID: <4E1C7BAD.5010208@perex.cz>
References: <s5hipr7h401.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 498C8248A6
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 18:51:58 +0200 (CEST)
In-Reply-To: <s5hipr7h401.wl%tiwai@suse.de>
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

Date 12.7.2011 18:12, Takashi Iwai wrote:
> [This is resent since I haven't seen my original post due to
>  alsa-project.org site down.  If you have already read it, please
>  disregard.]
> 
> Hi,
> 
> in upcoming 3.0-kernel era, I believe it's high time to drop the
> support of old 2.2/2.4 kernels in alsa-driver external builds.
> Recently I changed some PCI drivers to use KBUILD_MODNAME, and this
> isn't supported by the old kernels, i.e. it's currently broken for
> these kernels.  But I have no more gut to patch alsa-driver/* codes.
> 
> Is there any active user of such kernels with the latest alsa-driver?
> If not, let's clean up the whole things.
> 2.2/2.4 kernel users can still use 1.0.24, and we can release 1.0.24.x
> series if really needed.

I agree. I believe that these kernels are using minimum users now.
Almost all embeded devices are using 2.6 kernels, too.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
