From: Peter Heatwole <peter599@gotnet.net>
Subject: Beta11 Release - PM Required?
Date: Tue, 19 Feb 2002 13:53:52 -0800
Message-ID: <20020219135352.A777@localhost>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

    I downloaded the beta11 tarball and attempted to compile. The compile
quitted with errors from alsa-kernel/core/pcm_native.c, stating that
the macros `snd_power_lock' and `snd_power_wait' had two arguments,
and pcm_native.c was passing only one. I didn't completely search out
the problem, but I did notice that core.h defines snd_power_* as either
functions or macros, depending on whether the kernel had been compiled
with power management support (CONFIG_PM). I enabled power management
and recompiled my kernel, and alsa-driver built without further
problems.

(I think there may have been other macros affected, but I haven't
reverted to a non PM-enabled kernel to check.)


RedHat 7.2
Kernel 2.4.17
gcc 2.96


-- Peter Heatwole
"Murphy was just a well known pessimist."

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
