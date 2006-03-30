From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: What is /dev/snd/hwC0D0 used for ?
Date: Thu, 30 Mar 2006 16:37:41 -0500
Message-ID: <1143754662.22530.9.camel@mindpipe>
References: <442C2CCE.5070207@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <442C2CCE.5070207@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-30 at 11:09 -0800, Carlos Munoz wrote:
> Hi all,
> 
> Does any anyone know what /dev/snd/hwCxDx and /dev/snd/timer are used for?
> 

Yes, these provide the ioctl() interface (specifically the hwdep and
timer ioctls, respectively) that alsa-lib uses to communicate with the
kernel.  They are only intended for use by alsa-lib.

> Is there a document explaining what all the devices are used for ? I 
> searched but didn't find anything.
> 

No because these interfaces are intended to be private to alsa-lib.  The
source code is authoritative.

Lee





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
