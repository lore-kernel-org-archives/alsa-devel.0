From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa userspace interface
Date: Mon, 19 Mar 2007 11:08:54 +0100
Message-ID: <1174298934.28822.1180148355@webmail.messagingengine.com>
References: <3BC073ED-BC5A-48AB-A3D0-21F3A23B4DDB@xant.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3BC073ED-BC5A-48AB-A3D0-21F3A23B4DDB@xant.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrea Guzzo <xant@xant.net>, alsa-devel@lists.sourceforge.net
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrea Guzzo wrote:
> we are wondering if it's possible to register an alsa device from
> userspace.

It is not possible to register a kernel device from userspace, but it is
possible to write a plugin that is used by the alsa library like a
kernel device.

Have a look into the alsa-plugins package.

> Is there any working or experimental one?

The FreeBoB project is writing an ALSA plugin for some IEEE1394 devices.

> Another interesting use of an hypothetical alsa userspace interface  
> for device drivers implementation would be the possibility to
> implement virtual audio devices ....for example you could implement a
> transparent sound server that doesn't require applications to support  
> it explicitly and to link specific libraries, but it would be simply
> accessed like any other alsa device and, with the use of substreams,
> it would allow multiple applications to access audio facilities....
> but this is another story :P

This story is called dmix.  This plugin has been part of alsa-lib for
years, and it doesn't need a server.  :-)


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
