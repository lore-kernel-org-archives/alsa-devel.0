From: vanDongen-Gilcher <gml@xs4all.nl>
Subject: Re: rme96 and mmap, bug?
Date: Thu, 28 Nov 2002 23:05:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0ClXrX057A140000.gml@xs4all.nl>
References: <200211271913.43032.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211271913.43032.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Out of curiosity,

What makes a card support mmap directly in general? And what would be 
missing?

Gerard



Anders Torger said at "Re: rme96 and mmap, bug?."r[2002/11/27 18:13]


> The hardware does not support memory mapped I/O, so it is copied by the 
> CPU in the interrupt handler. Thus for that card you gain nothing from 
> using memory mapped I/O, it was only implemented for compability.


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
