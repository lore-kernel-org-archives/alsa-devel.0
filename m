From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: crash trace under gdb
Date: Fri, 09 May 2003 19:28:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBBE54F.8020808@libero.it>
References: <s5hd6isb3m1.wl@alsa2.suse.de>	<20030509153542.E0A9D14CE5@Cantor.suse.de> <s5h3cjow2in.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cjow2in.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:
> At Fri, 09 May 2003 11:39:42 -0400,
> Paul Davis wrote:
> 
>>>how about alt-sysrq-T ?
>>
>>all this "proves" is that yes, its the lock code because we're running
>>in interrupt context, not in process context. 
>>
>>so something in the code jaroslav added is broken, at least for SMP.
>>
>>i just hope sf.net will let me get my hands on an older copy so i can
>>keep working ...
> 
> 
> you can use the CVS snapshot tarball for the old versions.  the
> changes for pcm substreams were done from Apr. 28, so Apr. 27 should
> be fine for this regard.
> or, the CVS repositry backup would be nice to track down the whole
> changes, but it's big (13MB).

However it would be nice if Paul help us to track down the source of the 
bug, or give a test case for someone willing to help and with access to 
SMP hardware.

Theoretically the new code should work, I guess there's only a trivial typo.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
