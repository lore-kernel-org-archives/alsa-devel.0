From: Dan Hollis <goemon@anime.net>
Subject: RE: question regarding latest CS4205 laptop    soundcard
 driver
Date: Tue, 26 Feb 2002 16:41:03 -0800 (PST)
Message-ID: <a5ha9t$3hn$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <000b01c1bf17$eadd9df0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: pshirkey@boosthardware.com, alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Feb 2002, Ivica Bukvic wrote:
> I am, however, baffled by what you had to say. Crystal company claims
> complete Linux "friendliness"

What is claimed and what is provided is two completely different things. 
Crystal still does not provide complete documentation for CS4630.

> and I've seen several sites which carry detailed specs of the CS4205 
> chip in PDF file, so I am not sure what aspect of the sound chip is 
> missing for such information to be complete.

CS4205 is purely a standard AC97 codec, it's only an AD/DA convertor and 
mixer. The real soundchip is in your laptop southbridge -- the intel 
82901. So use the alsa 'intel8x0' driver.

> Also, is there a way to contact Crystal company and request additional
> info?

IIRC there are some crystal guys on the list. They have promised some 
future solution to the CS4630 problem but nothing has happened yet.

> P.S. What about Yamaha/Intel 753 chip that is found in the Toshiba
> Satellite 5005's?

All yamaha 75x should be supported with the alsa 'ymfpci' driver.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
