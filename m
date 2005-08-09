From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Alsa-lib problem
Date: Tue, 09 Aug 2005 18:05:04 -0400
Message-ID: <1123625105.19486.4.camel@mindpipe>
References: <6A09F73E2878E447BF6B87C43162C827021545A4@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <6A09F73E2878E447BF6B87C43162C827021545A4@excwa1b2.sharpsec.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Nambiar, Anil" <NambiarA@sharpsec.com>
Cc: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-09 at 17:57 -0400, Nambiar, Anil wrote:
> Hi,
> 
>             I am developing ALSA based sound driver for our arm based
> soc. The driver is built as part of the kernel rather than as a
> loadable module. If I run a simple wave player which has OSS based
> interface, it works fine. Even mplayer works fine in OSS emulation
> mode. But if I run any native alsa based player it gives error opening
> the device. For eg: running 'aplay -D default demo.wav" give the
> following error: 
> 
> ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM default
> 
> aplay: main:533: audio open error: No such file or directory

It looks like alsa-lib is not finding the default PCM config for your
chip.  Someone else developing a driver for ARM reported the same
problem.

Try stracing the aplay process, you will see alsa-lib trying to open the
various config files ~/.asoundrc, /etc/asound.conf, and (most
important) /usr/share/alsa/*, and compare the results to what you get
when you strace aplay on a known good driver like snd-intel8x0.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
