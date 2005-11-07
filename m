From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Au1550 OSS driver issues
Date: Mon, 07 Nov 2005 15:19:14 -0500
Message-ID: <1131394755.8383.92.camel@mindpipe>
References: <43452054.2090305@ru.mvista.com>
	 <436FB1DE.6010405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <436FB1DE.6010405@ru.mvista.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: Linux MIPS Development <linux-mips@linux-mips.org>, alsa-devel@lists.sourceforge.net, dan@embeddededge.com, Pete Popov <ppopov@embeddedalley.com>, Konstantin Baidarov <kbaidarov@ru.mvista.com>, Manish Lachwani <mlachwani@mvista.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-07 at 22:58 +0300, Sergei Shtylylov wrote:
>          After having a look at sound/oss/au1000.c, here's an updated patch 
> that deals with "nested" spinlocks the same way that driver does, and adds 
> spinlock to start_adc() as well.

The OSS drivers are scheduled for removal, it's unlikely that this will
be accepted into the kernel.  It also has nothing to do with ALSA.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
