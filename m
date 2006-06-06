From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS/ALSA issue
Date: Tue, 06 Jun 2006 16:37:51 -0400
Message-ID: <1149626271.4072.60.camel@mindpipe>
References: <200606062157.43489.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200606062157.43489.alien999999999@users.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alien <alien999999999@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-06 at 21:57 +0200, Alien wrote:
> as a result, the sound was played, all sound looped (also flash), and
> a few 
> hours later, my /var/log/kernel/warnings was > 600MB (kernel
> warnings).
> 
> 
> Now, we all know that:
> 
> 1. ALSA has hardware mixing if the chipset/driver supports it (i know
> mine does).
> 
> 2. OSS does not do any multiple sounds

It should work.  ALSA's OSS emulation supports mixing if the card has
hardware mixing.  It is only in the case of software mixing that OSS
emulation cannot support multiple open.

Sounds like a driver bug.  What do the kernel warnings say?

Lee
