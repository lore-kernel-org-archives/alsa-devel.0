From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sequencer filter client
Date: Mon, 26 Jan 2004 14:57:40 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401261453170.24795-100000@studcom.urz.uni-halle.de>
References: <4011916D.4040601@colorado.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4011916D.4040601@colorado.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Garett Shulman <shulmang@colorado.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Garett Shulman wrote:
> Hello, I am trying to create a very simple midi filter client for the
> alsa sequencer based on aseqview-0.1.4. I have alsa 0.9.8. This code
> shows the input and the output port in aconnect when executed. And, when
> the raw_midi client is connected The callback does get called when I
> play keys on my piano. However, Its as though the message is getting
> sent back to this client and  not on to the next client.
>
> int process_event(port_t *p, int type, snd_seq_event_t *ev, int *priate_data)
> {
>     port_write_event(p, ev, 0);
> }

The event will be sent to the destination as specified in ev->dest.
For events you have just received, the destination is your own
client/port.

Call snd_seq_ev_set_source(ev, ?) to set your source port, and call
snd_seq_ev_set_subs(ev) to specify that the event is to be sent to all
ports subscribed to your port.


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
