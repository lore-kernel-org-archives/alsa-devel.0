From: John covici <covici@ccs.covici.com>
Subject: Re: via8xxx invalid cur_ptr
Date: Tue, 8 Apr 2003 12:49:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16018.64905.4784.752391@ccs.covici.com>
References: <m3adf69tpq.fsf@ccs.covici.com>
	<s5hfzotq6x1.wl@alsa2.suse.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzotq6x1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: John Covici <covici@ccs.covici.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

on Tuesday 04/08/2003 Takashi Iwai(tiwai@suse.de) wrote
 > At Fri, 04 Apr 2003 10:18:41 -0500,
 > John Covici wrote:
 > > 
 > > I am getting messages like the following in my logs using kernel
 > > 2.4.20-xfs and alsa 0.9.2 release:
 > > 
 > > Apr  3 23:27:52 ccs kernel: ALSA ../alsa-kernel/pci/via82xx.c:675: invalid via82xx_cur_ptr, using last valid pointer
 > > 
 > > What does this mean and have you fixed it yet?
 > 
 > how often do you see this message?  which program?

Every couple of minutes using freeamp or speakfreely both of which
are using the oss emulation.
 > the playback works otherwise?
 > 
 > also, please tell the chip revision (or output of
 > /proc/asound/cards).  the behavior of via82xx driver depends on the
 > chip model.

0 [via8233        ]: VIA8233 - VIA 8233
                     VIA 8233 at 0xc000, irq 11


 > 
 > if you're using VIA8233A (not 8233,8233C,8235), please try hw:0,1 for
 > aplay.
 > 
 > 
 > thanks,
 > 
 > Takashi

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
