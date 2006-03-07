From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Tue, 07 Mar 2006 15:01:48 +0100
Message-ID: <440D924C.5090507@cendio.se>
References: <43F09D76.9060004@cendio.se> <20060214094741.GA8943@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DB041BC
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 15:01:50 +0100 (MET)
In-Reply-To: <20060214094741.GA8943@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> 
> And you're speaking with mplayer's ALSA driver maintainer.
> Is there anything wrong with mplayer?  ;-)
> 

I can now answer yes to this! :)

This little snippet causes me grief:

     if ((err = snd_card_next(&cards)) < 0 || cards < 0)
     {
       mp_msg(MSGT_AO,MSGL_ERR,"alsa-init: no soundcards found: %s\n", 
snd_strerror(err));
       return(0);
     }

mplayer does not require an actual, physical sound card (which is what 
this detects), so please don't check for one.

Rgds
-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
