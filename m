From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Compilation procedure from git/tiwai/sound-2.6.git
Date: Fri, 02 Oct 2009 11:32:13 +0200
Message-ID: <4AC5C89D.9030708@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>	<s5hpr9kwfqr.wl%tiwai@suse.de>
	<4AB7C810.7060402@ivitera.com>	<s5h4oqwxfoq.wl%tiwai@suse.de>
	<4AC50BE0.9050206@ivitera.com> <s5htyyil4zl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EDB210394C
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 11:31:50 +0200 (CEST)
In-Reply-To: <s5htyyil4zl.wl%tiwai@suse.de>
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
> At Thu, 01 Oct 2009 22:06:56 +0200,
> Pavel Hofman wrote:
>> Takashi Iwai wrote:
>>> At Mon, 21 Sep 2009 20:38:08 +0200,
>>>
>>> Use sound-2.6.git tree on kernel.org together with alsa-driver-build.git
>>> tree:
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
>>>
>> Hi Takashi,
>>
>> I am sorry if I overlooked something but the gitcompile in
>> alsa-driver-build.git does not work with the sound-2.6.git:
> 
> First run utils/setup-alsa-kernel with the path to sound-2.6 git
> tree.  See "Compilation from Linux kernel tree" section in INSTALL
> file.
> 
> The file structure of alsa-kernel isn't identical with linux kernel.
> 


Hi Takashi,

Thanks a lot, it works fine now. Should I add this information to the
alsa-project wiki?

Please could you commit the following patch? I had to check the script
code to find out the actual meaning.

Thanks,

Pavel.


diff --git a/utils/setup-alsa-kernel b/utils/setup-alsa-kernel
index 47ecfe4..75be3b3 100755
--- a/utils/setup-alsa-kernel
+++ b/utils/setup-alsa-kernel
@@ -22,7 +22,7 @@ if [ -z "$1" ]; then
 fi

 if [ ! -d acore ]; then
-    echo "Run this script on alsa-driver directory"
+    echo "Run this script in alsa-driver directory"
     exit 1
 fi
