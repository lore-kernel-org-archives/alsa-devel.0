From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: removing events from queue according to tag
Date: Thu, 3 Mar 2005 08:54:43 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503030853420.29392-100000@studcom.urz.uni-halle.de>
References: <20050302115858.69453.qmail@web51902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050302115858.69453.qmail@web51902.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michael Geis wrote:
> snd_seq_remove_events_set_condition(remove,SND_SEQ_REMOVE_OUTPUT);
> snd_seq_remove_events_set_condition(remove,SND_SEQ_REMOVE_TAG_MATCH);

Make that

snd_seq_remove_events_set_condition(remove,SND_SEQ_REMOVE_OUTPUT |
                                           SND_SEQ_REMOVE_TAG_MATCH);


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
