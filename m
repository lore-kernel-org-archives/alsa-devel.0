From: Garett Shulman <shulmang@colorado.edu>
Subject: sequencer filter client
Date: Fri, 23 Jan 2004 14:26:05 -0700
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <4011916D.4040601@colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I am trying to create a very simple midi filter client for the 
alsa sequencer based on aseqview-0.1.4. I have alsa 0.9.8. This code 
shows the input and the output port in aconnect when executed. And, when 
the raw_midi client is connected The callback does get called when I 
play keys on my piano. However, Its as though the message is getting 
sent back to this client and  not on to the next client. The 
process_event function keeps getting called over and over again with the 
same message when I hit one piano key. It's as though it is sending 
itself the message. Any Ideas are greatly appreciated. -Garett

#include "portlib.h"

int process_event(port_t *p, int type, snd_seq_event_t *ev, int 
*priate_data)
{
    port_write_event(p, ev, 0);
}

int main()
{
        unsigned int caps = SND_SEQ_PORT_CAP_WRITE | 
SND_SEQ_PORT_CAP_SUBS_WRITE | SND_SEQ_PORT_CAP_READ | 
SND_SEQ_PORT_CAP_SUBS_READ;

        port_client_t *client = port_client_new("MIDI filter", 
SND_SEQ_OPEN_DUPLEX);
        port_t *port = port_attach(client, "FILTER port", caps, 
SND_SEQ_PORT_TYPE_MIDI_GENERIC);
        int *priv_data;

        /* add callback */
        port_add_callback(port, PORT_MIDI_EVENT_CB, 
(port_callback_t)process_event, priv_data);

        port_client_do_loop(client);

        return port_detach(port);
}


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
