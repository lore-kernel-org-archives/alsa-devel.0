From: "Pavana Sharma" <pavans@india.ti.com>
Subject: RE: Alsa-devel digest, Vol 1 #1786 - 3 msgs
Date: Thu, 1 Apr 2004 14:37:15 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01be01c417c8$babb6d80$f8b6a8c0@ent.ti.com>
References: <E1B8tPe-0001Aq-Ht@sc8-sf-list2.sourceforge.net>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1B8tPe-0001Aq-Ht@sc8-sf-list2.sourceforge.net>
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

Hi,
I am new to ALSA driver impementation. I am registering the  driver
interface functions like (probe,remove) using driver_register call. I expect
that the probe function will be called in which I am allocating sound card
and registering the card using snd_card_register. When I compile the sound
driver as a static module and boot my kernel I see that the init function in
which I am registering the device is getting called but the probe function
is not getting called.
We see a message from sound/last.c file asla_sound_last_init fucntion where
it searches snd_Cards array to find whether any sound cards are registered.
As our sound card card is not registered(because probe is not getting
called), we see a messaged "No Soundcards found".

Can someone give us some clues like why probe function is not getting
called??


Regards,
Pavana



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
