From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: configuration space never flattened? Bug?
Date: Thu, 29 Apr 2004 21:56:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56-Maildir.0404292133320.7156@yme.midgardsormen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm having trouble doing snd_pcm_hw_params_can_pause() on a certain pcm,
even though it has already (hopefully?) been fixed to one config by
snd_pcm_hw_params()... snd_pcm_hw_params has been called, at least. How
can I check?

fileja {
        type file
        file /tmp/alsa
        slave.pcm null
}

Program: latest xine

Error message:

xine: pcm.c:2604: snd_pcm_hw_params_can_pause: Assertion `params && params->info != ~0U' failed.

... commenting out the offending call and hardcoding success Seems To Work
(TM) but is of course a hack at best.

(BTW. Using this pcm definition, named pipe /tmp/alsa and ecasound reading
from the named pipe, I now have multichannel ladspa plugins working on the
sound stream from xine. Not-at-all in sync with video, but better than
nothing :)

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
