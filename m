From: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Subject: creating/deleting MIDI events
Date: Mon, 20 Oct 2003 15:32:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F93E3ED.8080807@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hello,

Question 1:

How do create a pointer and allocate memory to variables of type 
snd_seq_event to generate events by software? The function 
snd_seq_create_event doesn't exist anymore...


Question 2:

snd_seq_event * event;
snd_seq_event_input( handle, &event );

This allocates memory, but how do I release it? The function 
snd_seq_free_event is marked as deprecated and seems to be empty.

Thanks for answers!

Bernhard


-- 

---------------------------------
Bernhard Gerlach
Fraunhofer AEMT
Am Helmholtzring 1 (Haus M)
98693 Ilmenau
Germany

mail: gerlacbd@emt.iis.fhg.de
---------------------------------



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
