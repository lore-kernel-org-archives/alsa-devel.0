From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ALC650 GPIO bits
Date: Wed, 03 Mar 2004 15:48:54 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4045FE66.1040701@superbug.demon.co.uk>
References: <s5h7jy2lzic.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jy2lzic.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
> 
> it seems that some mobo with ALC650 uses GPIO 0 as the mic bias +5V.
> 
> in ac97_patch.c, the GPIO 0 is turned on/off in conjunction with
> the mic/center sharing switch, but this handling appears only for the
> old ALC650 revision (D or older).
> 
> interestingly, there is a report that even a mobo with the newer
> revision of ALC650 has this GPIO bit.
> now, the question is why GPIO is not handled with the revision E and
> F.  i can't remember the reason (google gives no good info) -- does
> anyone still know?
> 
> is there any mobo with a side effect of this GPIO?
> 
> 
> Takashi
> 

The best source I found for ALC650 info is from the Realtek web site.
http://www.realtek.com.tw/downloads/dlac97-1.aspx
1) They have a datasheet for the ALC650, although the datasheets have 
errors in them.
http://www.realtek.com.tw/downloads/downloads1-3.aspx?lineid=5&famid=12&series=8&Spec=True&refdesign=True

2) They have their own version of the alsa-driver, which you can look at 
to see what they do about things like this. Just download their linux 
driver. It is alsa-driver source code.
http://www.realtek.com.tw/downloads/dlac97-2.aspx?lineid=5&famid=12&series=8&Software=True#8Unix%20(Linux)

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
