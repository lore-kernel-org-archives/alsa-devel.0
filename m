From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: C-Media	CMI9761A REV
Date: Sat, 19 Feb 2005 04:52:44 +0100
Message-ID: <4216B80C.2090507@gmx.de>
References: <1108782279.23185.38.camel@bastov>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108782279.23185.38.camel@bastov>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sergio@sergiomb.no-ip.org
Cc: Jakob Schurdak <jakobs@myrealbox.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sergio Monteiro Basto wrote:

> I have one ASRock P4VT8+ with CMedia CMI9761 (not the same of Jakob) but
> same rev. of sound card.
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)

BTW, THATS NOT THE CODEC, only a interface.

this is it:

lspci -v

  0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
         Subsystem: Unknown device 1849:9761 <--------------------

tom



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
