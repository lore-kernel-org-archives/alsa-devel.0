From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem writing to PCM plugin
Date: Wed, 11 Aug 2004 17:03:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408111701200.1788@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408111544140.15385-100000@studcom.urz.uni-halle.de>
 <opsckpkuvbfmr65f@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <opsckpkuvbfmr65f@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Aug 2004, Arve Knudsen wrote:

> Based on your suggestion I rewrote the plugin, so it wraps a route plugin.  
> And now things work as I would expect. I must say I'm still confused on  
> the issue, as I haven't found any explanation why my original approach  
> wouldn't work. What's the difference between defining a translation table  
> directly inside a "plug" plugin, and aggregating a slave "route" plugin  
> within a "plug"?

There was an error in the plug plugin - one route plugin was inserted by 
mistake. This patch will fix the wrong plug behaviour:

Index: pcm_plug.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_plug.c,v
retrieving revision 1.126
diff -u -r1.126 pcm_plug.c
--- pcm_plug.c	19 Apr 2004 13:24:19 -0000	1.126
+++ pcm_plug.c	11 Aug 2004 15:06:02 -0000
@@ -53,7 +53,7 @@
 	int srate;
 	enum snd_pcm_plug_route_policy route_policy;
 	snd_pcm_route_ttable_entry_t *ttable;
-	int ttable_ok;
+	int ttable_ok, ttable_last;
 	unsigned int tt_ssize, tt_cused, tt_sused;
 } snd_pcm_plug_t;
 
@@ -361,7 +361,8 @@
 	snd_pcm_route_ttable_entry_t *ttable;
 	int err;
 	assert(snd_pcm_format_linear(slv->format));
-	if (clt->channels == slv->channels && !plug->ttable)
+	if (clt->channels == slv->channels &&
+	    (!plug->ttable || !plug->ttable_last))
 		return 0;
 	if (clt->rate != slv->rate &&
 	    clt->channels > slv->channels)
@@ -560,7 +561,7 @@
 	};
 	snd_pcm_plug_params_t p = *slave;
 	unsigned int k = 0;
-	plug->ttable_ok = 0;
+	plug->ttable_ok = plug->ttable_last = 0;
 	while (client->format != p.format ||
 	       client->channels != p.channels ||
 	       client->rate != p.rate ||
@@ -584,6 +585,7 @@
 	if (plug->ttable && !plug->ttable_ok) {
 		snd_pcm_t *new;
 		int err;
+		plug->ttable_last = 1;
 		err = snd_pcm_plug_change_channels(pcm, &new, client, &p);
 		if (err < 0) {
 			snd_pcm_plug_clear(pcm);

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
