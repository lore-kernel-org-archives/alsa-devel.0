From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: crash trace under gdb
Date: Fri, 09 May 2003 19:57:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBBEC25.7090909@libero.it>
References: <E19EBut-0002ql-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19EBut-0002ql-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis ha scritto:
>>However it would be nice if Paul help us to track down the source of the 
>>bug, or give a test case for someone willing to help and with access to 
>>SMP hardware.
> 
> 
> i'm happy to help out, but there's very little information available
> from the system when it happens. it also turns out (unsuprisingly) not
> to require gdb at all: the last time it happened, i started JACK up
> and within a few seconds the system was locked.

1) Are you using linked streams?
2) What's the complete call trace on lock (alt-sysrq-T)?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
