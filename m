From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Fw: [Bug 76413] arts does not follow ALSA API
Date: Fri, 19 Mar 2004 17:02:45 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405B27B5.8070509@superbug.demon.co.uk>
References: <20040319162344.2cd6363f.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040319162344.2cd6363f.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Florian Schmidt wrote:
> He sounds pissed..  :) If you get pissed by these forwards, please tell
> me.. I figured they might be of interest..
> 
> Begin forwarded message:
> 
> Date: 19 Mar 2004 15:05:31 -0000
> From: Allan Sandfeld <kde@carewolf.com>
> To: mista.tapas@gmx.net
> Subject: [Bug 76413] arts does not follow ALSA API 
> 
> 
> ------- You are receiving this mail because: -------
> You are a voter for the bug, or are watching someone who is.
>       
> http://bugs.kde.org/show_bug.cgi?id=76413      
> 
> 
> 
> 
> ------- Additional Comments From kde carewolf com  2004-03-19 16:05
> -------
> CVS commit by carewolf: 
> 
> After venting my fury I calmed down and looked at the dmix-code. It
> seems 
> it is really more borken than broken, and nothing we can't work around.
> 
> - Make aRts work with dmix. Two important changes:
>   1. Dmix uses read-events to signify write-events, so we need to
> autodetect 
>      what kind of crack ALSA is smoking today.
>   2. Dmix needs to be started like a recorder even if this is contrary
>      to the ALSA API documentation.
> 
> If everything works like expected I will backport and close bugs 76413
> and 70802.
> 
> CCMAIL: 76413 bugs kde org
> CCMAIL: 70802 bugs kde org
> 
> 
>   M +110 -48   audioioalsa9.cc   1.6
> 
> 
> 
If there is a bug in alsa, we will fix it.
Can you post a small program to demonstrate the problem.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
