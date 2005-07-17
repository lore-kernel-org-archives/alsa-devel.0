From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: compile error in wine
Date: Sat, 16 Jul 2005 23:21:10 -0400
Message-ID: <1121570471.13990.6.camel@mindpipe>
References: <20050716204029.53076898E7@sc8-sf-spam1.sourceforge.net>
	 <1121604285.8251.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121604285.8251.10.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Geoff Beasley <songshop@bizmedia.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-07-17 at 12:44 +0000, Geoff Beasley wrote:
> Is there something that needs to be edited
> in /usr/include/alsa/conf.h ?

Does this patch help?

--- /usr/include/alsa/conf.h~	2005-07-02 19:49:11.000000000 -0400
+++ /usr/include/alsa/conf.h	2005-07-16 23:19:16.000000000 -0400
@@ -173,19 +173,19 @@
 /* Names functions */
 
 /**
- * Device-name list element
- */
-typedef struct snd_devname snd_devname_t;
-
-/**
  * Device-name list element (definition)
  */
 struct snd_devname {
 	char *name;	/**< Device name string */
 	char *comment;	/**< Comments */
-	snd_devname_t *next;	/**< Next pointer */
+	struct snd_devname *next;	/**< Next pointer */
 };
 
+/**
+ * Device-name list element
+ */
+typedef struct snd_devname snd_devname_t;
+
 int snd_names_list(const char *iface, snd_devname_t **list);
 void snd_names_list_free(snd_devname_t *list);
 




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
