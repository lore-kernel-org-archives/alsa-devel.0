From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: creating/deleting MIDI events
Date: Tue, 21 Oct 2003 09:36:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310210928580.2396-100000@studcom.urz.uni-halle.de>
References: <3F93E3ED.8080807@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3F93E3ED.8080807@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bernhard Gerlach wrote:
> How do create a pointer and allocate memory to variables of type
> snd_seq_event to generate events by software? The function
> snd_seq_create_event doesn't exist anymore...

Use a standard pointer, and malloc/calloc/whateveralloc.
You can allocate events directly on the stack (without pointers), too.

> snd_seq_event * event;
> snd_seq_event_input( handle, &event );
>
> This allocates memory, but how do I release it? The function
> snd_seq_free_event is marked as deprecated and seems to be empty.

The event lives in some internal buffer managed by the ALSA library.
Simply don't do anything to free it.

The event buffer may be reused by the next snd_seq_event_input() call.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
