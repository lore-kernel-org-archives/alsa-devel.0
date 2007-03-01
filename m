From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [Jackit-devel] alsaseq reorders my events
Date: Thu, 01 Mar 2007 17:59:22 +0100
Message-ID: <1172768362.11019.1177218661@webmail.messagingengine.com>
References: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: jackit-devel-bounces@lists.sourceforge.net
Errors-To: jackit-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>, alsa-devel@lists.sourceforge.net, Jack Dev List <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dmitry Baikov wrote:
> I nearly finished alsaseq driver for jackmidi, but have a problem.
> Alsaseq reorders events in fast sequences, so note-on/note-off pairs got
> mixed.

Events with the same timestamp are delivered in strict FIFO order.

> The algorithm of sending is simple:
> 
>  		snd_seq_ev_schedule_real(&alsa_event, output_que, 1, &timestamp);
>  		...
> 		timestamp.tv_sec = (long) (offset / 1000000000);
> 		timestamp.tv_nsec = (long) (offset % 1000000000);
>  		snd_seq_event_output(self->seq, &alsa_event);

Does this code really compute the time stamp _after_ setting it?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
