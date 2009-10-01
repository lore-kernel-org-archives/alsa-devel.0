From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Compilation procedure from git/tiwai/sound-2.6.git
Date: Thu, 01 Oct 2009 22:06:56 +0200
Message-ID: <4AC50BE0.9050206@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>	<s5hpr9kwfqr.wl%tiwai@suse.de>	<4AB7C810.7060402@ivitera.com>
	<s5h4oqwxfoq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.pilsfree.net (mail.pilsfree.net [81.201.60.141])
	by alsa0.perex.cz (Postfix) with ESMTP id CF06A245DB
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 22:07:04 +0200 (CEST)
In-Reply-To: <s5h4oqwxfoq.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Mon, 21 Sep 2009 20:38:08 +0200,
> 
> Use sound-2.6.git tree on kernel.org together with alsa-driver-build.git
> tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
> 

Hi Takashi,

I am sorry if I overlooked something but the gitcompile in
alsa-driver-build.git does not work with the sound-2.6.git:

The command is:
pavel@nahore:~/projects/alsa-git/alsa-driver-build$\
ALSAKERNELDIR=/home/pavel/projects/alsa-git/sound-2.6/sound/\
./gitcompile --with-cards="ice1724,usb-audio"

(backslash stands for one line)

gitcompile ends up with:

Hacking autoconf.h...
make[1]: Entering directory
`/home/pavel/projects/alsa-git/alsa-driver-build/include'
make -C sound prepare
make[2]: Entering directory
`/home/pavel/projects/alsa-git/alsa-driver-build/include/sound'
make prepare2
make[3]: Entering directory
`/home/pavel/projects/alsa-git/alsa-driver-build/include/sound'
cp ../../alsa-kernel/include/*.h .
cp: cannot stat `../../alsa-kernel/include/*.h': No such file or directory
make[3]: *** [*.h] Error 1
make[3]: Leaving directory
`/home/pavel/projects/alsa-git/alsa-driver-build/include/sound'
make[2]: *** [prepare] Error 2
make[2]: Leaving directory
`/home/pavel/projects/alsa-git/alsa-driver-build/include/sound'
make[1]: *** [prepare] Error 2
make[1]: Leaving directory
`/home/pavel/projects/alsa-git/alsa-driver-build/include'
make: *** [dep] Error 1


Thanks a lot for a brief description of the compilation procedure.

Best regards,


Pavel Hofman.
