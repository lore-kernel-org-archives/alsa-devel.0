From: jfm3 <jfm3@ouroboros-complex.org>
Subject: Re: pcmcia hdsp problems
Date: 08 May 2003 13:26:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052414802.1344.59.camel@localhost.localdomain>
References: <20030508171650.2E25C2811C@ludo.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030508171650.2E25C2811C@ludo.dreamhost.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-05-08 at 13:18, Paul Davis wrote:
> it didn't work because of the erroneous PCI ID that appeared for the
> h/w. the hammerfall-mem module counts how many Hammerfall-ish devices
> it can find, and allocates memory for them. a device claiming to be
> vendor 0xffff is not only illegal, its definitely not a hammerfall :)
> 
> --p

Thanks. I had gathered as much. Is there a way to tell
snd-hammerfall-mem to allocate memory for a card even if it doesn't find
one? I'd like to be able to put the pcmcia card in after the machine
boots. The enable parameter to snd-hammerfall-mem doesn't seem to do
anything anymore.

This is especially important to me right now because for some reason the
pcmcia interface is not found correctly at boot time, only when the card
is inserted after hotplug has started...

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
