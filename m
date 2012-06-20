From: Ru Vuott <vuott@yahoo.it>
Subject: Tempo event in a Midi sequencer...
Date: Wed, 20 Jun 2012 21:17:09 +0100 (BST)
Message-ID: <1340223429.16177.YahooMailClassic@web29601.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm13-vm1.bullet.mail.ird.yahoo.com
	(nm13-vm1.bullet.mail.ird.yahoo.com [77.238.189.209])
	by alsa0.perex.cz (Postfix) with SMTP id 63893246FA
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 22:26:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I am finally able to make a simple midi sequencer with the Gambas language. It works, but I have some little problem about changing the metronomic Tempo within a midi song.
Since I used the method of sending an Echo event to send Midi Messages groups to ALSA, I thought I'd solve the problem of an eventual return of metronomic Time by sending an echo and backing from Alsa custom (Type: 90). At the time of receipt of the echo by the Alsa function:

int snd_seq_event_input(snd_seq_t *handle, snd_seq_event_t **ev)


the code sends the value of the tempo to a routine, where there are these Alsa functions:
snd_seq_queue_tempo_malloc(...)
snd_seq_queue_tempo_set_tempo(...)
snd_seq_set_queue_tempo(...)
snd_seq_queue_tempo_free(...)

...obviously with teir parametres.
I noticed, though, unfortunately (incomprehensibly) that often the change is a bit 'earlier than required. I do not think there is a problem of Delta Time, since the Delta Time of metronomic Tempo event is treated the same way as that relating to other MIDI events.
Looking for a solution, I had a look at the code of your Aplaymidi, and I saw this statement:

case 0x51: /* tempo */
    ......
    ...etc
    event->type = SND_SEQ_EVENT_TEMPO;
    ...etc,

so, I thought that the change of Tempo occur simply by sending an event by identifying it with precisely the type number: 35. I performed the test, checking the result is listening to the song, seeing both as reported by Aseqdump.
I guess it Aseqdump me signals a correct delivery, because it gives me back this response:
   queue + a number depending on the value sent with the Tempo event.

Instead, listening to the midi track, the change does not happen!
I am writing to ask you, if my analysis is correct, and if it is sufficient to send only time that event, or if some function of Alsa is absolutely necessary

Thanks
Vuotttttttt
