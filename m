From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Fri, 31 May 2002 18:31:58 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF7430E.F1994375@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
		<3CF5B58B.59E5A233@boosthardware.com> <s5hwutkhhhj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Takashi Iwai wrote:
> 
> > devfs: devfs_register(): device already registered: "unknown"
> > ALSA usbaudio.c:1191: 3:4:1 : frame size 3 doesn't match ALSA 24bit
> > sample format
> 
> oh, that's interesting.  apparently the device uses 3 bytes for 24bit
> sample format.  alsa supports only 4bytes-packed format, so far.
> that's not expected.
> 

Damn. I assume it is not simple to incorporate.

> > devfs: devfs_register(): device already registered: "unknown"
> 
> this is a bug of sound_core.c.  you can fix it by replacing
> sound_core.c with the one in alsa-kernel tree.
> 

General question. Is the above likely to cause problems if I don't swap
them?

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
