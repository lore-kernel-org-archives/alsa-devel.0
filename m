From: Paul Davis <pbd@op.net>
Subject: Re: Re: hdsp on big-endian
Date: Wed, 22 May 2002 09:56:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17AWZX-00026H-00@usw-sf-list1.sourceforge.net>
References: <s5hoff8fg62.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 22 May 2002 15:47:17 +0200."
             <s5hoff8fg62.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>basically PCI bus is accessed as LE.  that's why in_le32 is used

OK, well apparently on OS X, either RME didn't use standard macros for
this (most likely), or there are no standard macros for this.

>there.  we can access to io without considration of endianess as long
>as using readX/writeX.

Sounds like it, yes. Very nice.

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
