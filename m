From: d <dieb13@klingt.org>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 16:14:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED615AA.2090408@klingt.org>
References: <E19LMvD-0004R1-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19LMvD-0004R1-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> we need a ksymoops-processed kernel panic trace.

ok, since i'm more a musician than a kernel-hacker, i don't exactly know 
what to do with the panic output.
i see EIP: 0010:[<c0280005>] and search for it in /var/log/ksymoops right?
there i find
...
c0106298 __up_wakeup
c02bfff4 csum_partial_copy_generic_Rsmp_e8aa9a96
...

so, what to do next?

> if it makes you feel any better, i wrote a lot of the driver, and i
> can't even load it right now: it locks up my system during the boot
> process unconditionally.

no, that makes me feel even more lost :(

regards
d13b




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
