From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Lockups with KDE 3.3.0 Beta 2 and Audigy 2 ZS
Date: Sun, 25 Jul 2004 19:07:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090796834.719.14.camel@mindpipe>
References: <200407251639.02671.jlp@holodeck1.com>
	 <200407252119.53700.jlp@holodeck1.com> <1090784215.14951.66.camel@mindpipe>
	 <200407260049.41454.jlp@holodeck1.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407260049.41454.jlp@holodeck1.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jure Repinc <jlp@holodeck1.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-07-25 at 18:49, Jure Repinc wrote:

> I tried with CVS compile but computer stil locks :(
> Anything else I could try?

Hmm, I did not see the part about your having a 64-bit system.  I
believe there are places in the driver (pci/emu10k1/emufx.c) where a
pointer is stored in an FX8010 GPR, which are 32 bits.  Someone on
alsa-devel might know better, I will cc that list.

Meanwhile, you should file a bug report with the ALSA bug tracker.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
