From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Can anyone help?
Date: Thu, 09 Feb 2006 18:19:29 -0500
Message-ID: <1139527169.30058.130.camel@mindpipe>
References: <1139526455.9296.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EB38D19E
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 00:19:39 +0100 (MET)
In-Reply-To: <1139526455.9296.5.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-09 at 23:07 +0000, Adrian McMenamin wrote:
> I cannot get aplay to work on my architecture (afaics anyway) eg
> 
> / # aplay -D hw:0,0 /bin/busybox
> aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
> Aborted
> 
> (Nobody has explained to me what that error is - and my reading of the
> code hasn't helped too much :-< )
> 
> So how can I test my driver code?
> 
> I can do things like this:
> 
> / # cat /bin/busybox > /dev/snd/pcmC0D0p
> ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In snd_aicapcm_pcm_open
> cat: Write Error: File descriptor in bad state
> / # Feb 10 00:01:02 dreamy user.warn kernel:
> ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In snd_aicapcm_pcm_open
> 
> But as the above fragment shows this opens the device file but not much
> else (as I assume it has no automagic way of accessing the alsa
> subsystem)

It looks like you fail to set card->id in your __devinit routine.  This
field is used by the alsa-lib to find the right config file
in /usr/share/alsa/cards/.  For example if alsa-lib is supposed to use 
/usr/share/alsa/cards/Audigy2.conf set it to "Audigy2".

The ID is available in /proc/asound/cardX/id.

Here is the code from the emu10k1 driver:

        if (!*card->id && c->id) { 
                int i, n = 0; 
                strlcpy(card->id, c->id, sizeof(card->id));
                for (;;) {
                        for (i = 0; i < snd_ecards_limit; i++) {
                                if (snd_cards[i] && !strcmp(snd_cards[i]->id, card->id))
                                        break;
                        }
                        if (i >= snd_ecards_limit)
                                break;
                        n++;
                        if (n >= SNDRV_CARDS)
                                break;
                        snprintf(card->id, sizeof(card->id), "%s_%d", c->id, n);
                }
        }


Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
