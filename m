From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Fri, 18 Jul 2008 18:31:14 +0200
Message-ID: <4880C552.50706@keyaccess.nl>
References: <BLU137-W51E7DF3E0152023F07FC0C958F0@phx.gbl>
	<487E42ED.7050000@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020206030901090906070801"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 4583024530
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 18:29:11 +0200 (CEST)
In-Reply-To: <487E42ED.7050000@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, alsa@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020206030901090906070801
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 16-07-08 20:50, Rene Herman wrote:

> Moreover, the AC97 codec seems integrated in the EV1938. Just found a
> patch for FreeBSD following up a similar report for your card. Will
> look at it tomorrow.

Nothing interesting. Ready to give up on this. There is a communication 
problem with the AC97 codec and that's the kind of thing which is almost 
impossible to debug via email, especially since apparently this is not 
different for the OSS driver; it's also not getting back a valid ID at 
least.

I do wonder a bit if that might mean that the only difference is the 
ALSA "mute by default" behaviour. The attached patch does away with the 
default muting of the AC97 controls. You'd apply it as before (after 
reverting the previous 2 patches as written earlier), "make", "make 
modules_install" and then load snd-ens1371:

# modprobe -r es1371
# modprobe -r snd-ens1371
# modprobe snd-ens1371

and then "aplay foo.wav" (without first starting alsamixer). If no 
sound, adjust levels in alsamixer, retry aplay, if no sound, reboot (to 
get the card to a startup state) and retry after the above 3 modprobes.

If for some unimagineable reason you still need "alsaconf" instead of 
just modprobe snd-ens1371 to load the driver, adjust accordingly. Have 
no idea why that would be the case.

If as expected you still have no sound I give up. Stared at this stuff, 
but am not seeing anything stand out. If you ever decide to replace the 
card and can find an ALSA developer in your neighbourhood to donate it 
to that could be interesting. I've never seen an EV1938 locally here; 
distribution is probably limited to the US.

Rene.

--------------020206030901090906070801
Content-Type: text/plain;
 name="ac97_dont_mute.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_dont_mute.diff"

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 4f4343d..97a4365 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1196,8 +1196,6 @@ static int snd_ac97_cmute_new_stereo(struct snd_card *card, char *name, int reg,
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
 		return err;
-	/* mute as default */
-	snd_ac97_write_cache(ac97, reg, val | mute_mask);
 	return 0;
 }
 

--------------020206030901090906070801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020206030901090906070801--
