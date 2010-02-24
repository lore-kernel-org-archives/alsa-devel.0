From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-compile.sh - easy testing of latest ALSA code
Date: Wed, 24 Feb 2010 13:20:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002241318430.28127@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1002221725120.28127@eeebox2.perex-int.cz>
	<s5h3a0s2wlu.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1002231003530.28127@eeebox2.perex-int.cz>
	<4B843EE7.2080602@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 14A0410390B
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 13:20:33 +0100 (CET)
In-Reply-To: <4B843EE7.2080602@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Feb 2010, Eliot Blennerhassett wrote:

> Jaroslav Kysela wrote:
>> On Tue, 23 Feb 2010, Takashi Iwai wrote:
>>> Just one point I noticed quickly is that the standard directory for
>>> update modules is either /lib/modules/$VERSION/updates or
>>> /lib/modules/$VERSION/extras.  We should follow that.
>>
>> The script just call 'make install-modules' in the alsa-driver package.
>> Anyway, overwriting kernel modules is just a workaround to bypass the
>> standard packaging. I don't think that using a special directory helps.
>
> I think it helps:
>
> Building drivers from source I usually configure --with-moddir=updates/alsa
>
> This means
> * The newly generated modules do not overwrite the distro supplied ones.
> * I can easily revert to the distro ones by deleting updates/alsa (my
> updates directory also has a dkms subdirectory) and rerunning depmod

OK. I got the point. It's fixed in the current alsa-compile.sh script. 
Also, the --kmodclean option was added to remove ALSA kernel modules in 
this location.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
