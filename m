From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: MIDI and PCMCIA
Date: 17 Jun 2003 22:59:43 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055890785.1029.32.camel@Jay>
References: <E19RJ5V-0004v1-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19RJ5V-0004v1-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On sab, 2003-06-14 at 22:06, Paul Davis wrote:
> >
> >Some of the cards by Echoaudio have a midi port, but it's not MPC401
> >compatible. The card has two tiny buffers to send and receive bytes. Where
> >can I get infos, sample code, etc. to add midi support to my driver ?
> >The Layla24 also exists in PCMCIA edition. Just like above, I need docs...

> no docs explicitly, but the hdsp (as just one example; there are
> others within the driver tree) has a midi port that is completely
> unrelated to MPC401. it also uses a tasklet to handle midi i/o so as
> not to affect audio latency.

Tnx, the code seems quite clear.

And about the PCMCIA ?


Bye.




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
