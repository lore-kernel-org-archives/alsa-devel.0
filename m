From: Charles Eidsness <charles.eidsness@rogers.com>
Subject: Data Transfer Question
Date: Mon, 14 Jun 2004 10:43:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40CDB99A.1050004@rogers.com>
Reply-To: charles.eidsness@rogers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fep04-mail.bloor.is.net.cable.rogers.com (fep04-mail.bloor.is.net.cable.rogers.com [66.185.86.74])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98E2536B
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2004 16:43:44 +0200 (MEST)
Received: from rogers.com ([24.157.59.167])
          by fep04-mail.bloor.is.net.cable.rogers.com
          (InterMail vM.5.01.05.12 201-253-122-126-112-20020820) with ESMTP
          id <20040614144132.QHJ8306.fep04-mail.bloor.is.net.cable.rogers.com@rogers.com>
          for <alsa-devel@alsa-project.org>;
          Mon, 14 Jun 2004 10:41:32 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm working on an ALSA driver for an embedded MIPS processor and am 
having trouble getting it to run at a rate > 16kHz.

What I've notice when it's running at 16kHz or less the ALSA API is 
calling  my pointer function before the first interrupt, i.e.

START
call pointer
interrupt (which calls snd_pcm_period_elapsed)
call pointer
call pointer
interrupt (which calls snd_pcm_period_elapsed)
.
.
.

And everything sounds fine, but when I run at > 16kHz it doesn't call 
the pointer function before the first interrupt, and after the first 
interrupt it stops and then starts, i.e.

START
interrupt (which calls snd_pcm_period_elapsed)
call pointer
STOP
START
interrupt (which calls snd_pcm_period_elapsed)
call pointer
STOP
.
.

And ends up sounding very choppy. Can anyone help shed some light on 
what's going on? Why is the API calling the pointer function before the 
first interrupt?

You can find my code here: 
http://members.rogers.com/charles.eidsness/au1000.c

Thanks,
Charles





-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
