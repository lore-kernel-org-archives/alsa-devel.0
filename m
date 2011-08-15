From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Questions about the alsa-driver-unstable tarballs
Date: Mon, 15 Aug 2011 11:58:10 +0200
Message-ID: <4E48EDB2.909@canonical.com>
References: <4E48D0D0.7020009@canonical.com> <s5h7h6f6nns.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id C5A6624589
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 11:58:17 +0200 (CEST)
In-Reply-To: <s5h7h6f6nns.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/15/2011 11:15 AM, Takashi Iwai wrote:
> At Mon, 15 Aug 2011 09:54:56 +0200,
> David Henningsson wrote:
>>
>> Hi Takashi,
>>
>> 1) there seems to be a build failure with current
>> alsa-driver-unstable-snapshot [1] :
>>
>> ...as alsa-kernel/soc/Makefile references a mxs/ directory, but this
>> directory is not present in the soc/ directory.
>
> Just forgot to update after merging sound git tree.
> Such a new build-stub has to be added manually.  Fixed now.

Thanks!

>> 2) it seems like the .bz2 version of alsa-driver-snapshot has
>> disappeared, is this intentional?
>
> tar.bz2 file is created on kernel.org server from tar.gz files
> automatically.  So when I upload a new tar.gz file, I delete tar.bz2
> file beforehand.  You seem to have looked at the directory just
> between my upload and the rebuild of tar.bz2 by the server.
>
> The same is true for alsa-driver-snapshot.tar.bz2, too, BTW.

Hmm, but the alsa-driver-snapshot.tar.bz2 seems still missing? Only 
alsa-driver-unstable-snapshot.tar.bz2 is present.

>> 3) Could you explain the difference between alsa-driver-snapshot and
>> alsa-driver-unstable-snapshot, and how the alsa-kernel.git,
>> alsa-driver.git and sound-2.6.git come together to form the two
>> different tarballs?
>
> alsa-driver-unstable-snapshot is created from a combination of
> sound-unstable-2.6.git and alsa-driver-build-unstable.git trees,
> while alsa-driver-snapshot is from a combination of sound-2.6.git and
> alsa-driver-build.git trees.  The commit ids of these trees are found
> in alsa-driver*/HEAD and alsa-driver*/alsa-kernel/HEAD files.

Okay, thanks for the explanation. This means that sound-2.6.git and 
alsa-driver-build.git are trees to remember unless told otherwise. 
Hopefully, the next time it breaks I hopefully will be able to also 
provide a patch against alsa-driver-build.git :-)

Btw, I've just got accepted by my manager(s) to go to Linuxcon and the 
audio BoF, so see you in Prague! I'll be there the full week.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
