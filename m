From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 07 Jun 2005 23:05:56 +0800
Message-ID: <42A5B7D4.50201@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<42A3B056.30405@netvigator.com> <s5h8y1n7af3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y1n7af3.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

The patch (diff11.diff) cause segmenation fault on my 32bit machine 
during /etc/init.d/alsasound start

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948

Do anyone know why readl() and writel() behave different in i386 
(32bits) and AMD64 (64bits) ?

http://sourceforge.net/mailarchive/message.php?msg_id=10773530


#ifndef CONFIG_X86_64

#define        hwread(x,y) readl((x)+((y)>>2))
#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))

#else

#define        hwread(x,y) readl((x)+(y))
#define        hwwrite(x,y,z) writel((z),(x)+(y))

#endif


Takashi Iwai wrote:
> At Mon, 06 Jun 2005 10:09:26 +0800,
> Raymond wrote:
> 
>>The au88x0 driver need patch to run on 64-bits platform.
>>
>>http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948
> 
> 
> Could you feed the patch to alsa-devel ML for review?
> (The addition of Signed-off-by would be preferred, too)
> 
> 







-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
