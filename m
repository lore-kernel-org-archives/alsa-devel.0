From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp driver updated in cvs?
Date: Wed, 12 Mar 2003 07:47:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18t5a0-0003zu-00@sc8-sf-list1.sourceforge.net>
References: <20030312111301.GA1404@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 12 Mar 2003 12:13:01 +0100."
             <20030312111301.GA1404@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm planning to install the current hdsp alsa drivers for a Hammerfall
>pci card with revision 11.
>
>1. are the most recent changes and patches to the hdsp already
>   commited to cvs or do I have to apply the patches posted to this
>   list?

i don't know. however, i also posted a 2nd version of the "firmware"
files yesterday that didn't make it to the list, so we really need to
know if its in CVS (use cvs -z3 status
{digi,multi}face_firmware_rev11.dat in the alsa-kernel/pci/rme9652
directory) or ask me for it. the first versions were unintentionally
truncated. 

>2. is the warm reboot still necessary with the current drivers?

no. that was caused by a missing byte written to the jTag register on
little endian platforms. it was fixed some time ago (i think marcus
fixed this).


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
