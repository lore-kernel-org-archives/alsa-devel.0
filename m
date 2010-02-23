From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-compile.sh - easy testing of latest ALSA code
Date: Tue, 23 Feb 2010 10:26:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002231003530.28127@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1002221725120.28127@eeebox2.perex-int.cz>
	<s5h3a0s2wlu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A6F310389F
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 10:26:14 +0100 (CET)
In-Reply-To: <s5h3a0s2wlu.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Feb 2010, Takashi Iwai wrote:

> At Mon, 22 Feb 2010 17:37:29 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> Hi all,
>>
>>  	I'm instroducing a new bash script - alsa-compile.sh - to allow
>> easy testing of new ALSA code by all users using standard Linux
>> desktop distributions. For example to get latest driver snapshot from
>> www.alsa-project.org, compile it and insert new kernel modules, just type:
>>
>>   wget -O alsa-compile.sh http://www.alsa-project.org/alsa-compile.sh
>>   chmod 755 alsa-compile.sh
>>   ./alsa-compile.sh --driver --kmodules
>>
>> More information are available using --help option.
>> More examples are available using --examples option.
>>
>> Actually, Fedora and openSUSE distributions are supported. Please,
>> send patches extending functionality for other distributions to this list
>> or directly to me.
>>
>> Takashi, you might want to add support (option) for your driver tarballs.
>> It would be probably a good idea to create a link to latest tarball in
>> your web directory.
>>
>> Please, send ideas, bugs, patches and any other issues to this list.
>
> Just one point I noticed quickly is that the standard directory for
> update modules is either /lib/modules/$VERSION/updates or
> /lib/modules/$VERSION/extras.  We should follow that.

The script just call 'make install-modules' in the alsa-driver package. 
Anyway, overwriting kernel modules is just a workaround to bypass the 
standard packaging. I don't think that using a special directory helps.

> I find this a good move in general.  But, wouldn't it be better to
> cooperate with the existing packaging?  For example, for openSUSE,
> there is already the snapshot RPM for each user-space stuff and the
> alsa-driver update KMP for all maintained distro versions on OBS.
> User can install the up-to-date packages simply via zypper without
> compiling.

You may add a new command to the script to handle latest distribution 
packages, something like:

   alsa-compile.sh --lib --install-snapshot-package

> OTOH, if the purpose is to make easier to install from the source
> tree, then we can give a spec or deb file, or a script to set up such
> files so that user can kick off the packager to have the
> installation-ready test package.

The purpose of this script is primary to compile and test latest sources. 
Installation is not the primary goal - many distributions uses own 
modifications and users can push package maintainers to upgrade the 
official distribution packages.

The idea is to have an independant script which allows users to test 
the latest ALSA code without the knowledge of the packaging and other 
distribution internals. We can do more interactive development using it 
with almost all users. I am going to add --patch option to apply test 
patches and do 'dmesg' output (for the driver package) which can be sent 
back to the developer working on a given issue.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
