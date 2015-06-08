From: Dan Nicholson <nicholson@endlessm.com>
Subject: Re: [PATCH] alsactl: Try to create state file directory
Date: Mon, 08 Jun 2015 09:17:49 -0700
Message-ID: <1433780269.8893.5.camel@midnight>
References: <1433541647-300-1-git-send-email-nicholson@endlessm.com>
 <s5hpp56ig55.wl-tiwai@suse.de>
 <CAJAOzpBuEC5=5p3-aChEf3dqWC4TXsK=JV5jzKp7u09Ju2Y2Xg@mail.gmail.com>
 <s5hd216ic86.wl-tiwai@suse.de> <s5h8ubuibby.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F575260442
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 18:17:53 +0200 (CEST)
Received: by qkhq76 with SMTP id q76so80421346qkh.2
 for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2015 09:17:52 -0700 (PDT)
In-Reply-To: <s5h8ubuibby.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-08 at 15:22 +0200, Takashi Iwai wrote:
> At Mon, 08 Jun 2015 15:03:21 +0200,
> Takashi Iwai wrote:
> > 
> > At Mon, 8 Jun 2015 05:52:18 -0700,
> > Dan Nicholson wrote:
> > > 
> > > On Jun 8, 2015 4:38 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
> > > >
> > > > At Fri,  5 Jun 2015 15:00:47 -0700,
> > > > Dan Nicholson wrote:
> > > > >
> > > > > Try to create the directory for the state file when saving so we don't
> > > > > depend on it being created ahead of time. This only checks for failures
> > > > > on existing directories and doesn't try to create the leading
> > > > > directories or workaround any other errors. This should catch the common
> > > > > case where /var/lib exists, but /var/lib/alsa doesn't.
> > > >
> > > > I don't think it's the role of alsactl.  It saves a file on the
> > > > certain directory.  If it doesn't exist, it's a failure of the
> > > > installed package.
> > > 
> > > Sure, that's understandable, but there's a couple reasons I think this is
> > > helpful addition.
> > > 
> > > First, if no path is supplied, store will save to /var/lib/alsa. So, it's
> > > not as of the user has supplied a path it didn't setup correctly. It would
> > > be nice if alsactl worked out of the box without additional integration by
> > > packagers.
> > 
> > For that, a safer way would be to create /var/lib/alsa in the
> > installation.'s 

Sure, as I said, we can do that if necessary. It's just another custom
thing to maintain, and I think it would be nice if alsactl could manage
this on its own.

> > > Second, my real motivation for fixing this is to support stateless type of
> > > systems that come with a clean /var. At Endless we're using ostree. The OS
> > > is composed by Debian packages, and indeed alsa-utils is setup to create
> > > /var/lib/alsa on install. However, to use the same OS snapshot for all
> > > users, the contents of /var are stripped since they represent local system
> > > state. We can certainly add a method for creating the directory at runtime,
> > > but we believe it's more robust to have the program manage its own state as
> > > much as possible.
> > 
> > Why not specifying the proper directory via alsactl -f option for
> > user?
> 
> Also, your patch seems to care only the top directory.  For example,
> if alsactl is configured to use /var/lib/alsa/more/deep/dir, it won't
> work.

Here's another version that creates all leading directories.

>From e1f75388682ad662dd5bdbb057d12b00e0aa80a8 Mon Sep 17 00:00:00 2001
From: Dan Nicholson <nicholson@endlessm.com>
Date: Fri, 5 Jun 2015 14:39:15 -0700
Subject: [PATCH] alsactl: Try to create state file directory

Try to create the directory for the state file when saving so we don't
depend on it being created ahead of time. This only checks for failures
on existing directories. This should catch the common case where
/var/lib exists, but /var/lib/alsa doesn't.

Signed-off-by: Dan Nicholson <nicholson@endlessm.com>
---
v3: Create all leading directories

 alsactl/state.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/alsactl/state.c b/alsactl/state.c
index 3908ec4..10b3567 100644
--- a/alsactl/state.c
+++ b/alsactl/state.c
@@ -27,6 +27,9 @@
 #include <stdio.h>
 #include <assert.h>
 #include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <alsa/asoundlib.h>
 #include "alsactl.h"
 
@@ -1536,6 +1539,41 @@ static int set_controls(int card, snd_config_t
*top, int doit)
 	return err;
 }
 
+static int create_directories(const char *file)
+{
+	int err = 0;
+	char *filedir, *cur;
+
+	filedir = strdup(file);
+	if (filedir == NULL) {
+		error("Not enough memory...");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	cur = filedir;
+	/* skip leading /s */
+	while (*cur && *cur == '/')
+		cur++;
+	while ((cur = strchr(cur, '/')) != NULL) {
+		mode_t mode = S_IRWXU | S_IRWXG | S_IRWXO;
+
+		*cur = '\0';
+		if (mkdir(filedir, mode) != 0 && errno != EEXIST) {
+			error("Could not create directory %s: %s",
+			      filedir, strerror(errno));
+			err = -errno;
+			goto out;
+		}
+		/* restore path element */
+		*cur++ = '/';
+	}
+
+out:
+	free(filedir);
+	return err;
+}
+
 int save_state(const char *file, const char *cardname)
 {
 	int err;
@@ -1561,6 +1599,9 @@ int save_state(const char *file, const char
*cardname)
 		}
 		strcpy(nfile, file);
 		strcat(nfile, ".new");
+		err = create_directories(file);
+		if (err < 0)
+			goto out;
 		lock_fd = state_lock(file, 10);
 		if (lock_fd < 0) {
 			err = lock_fd;
-- 
1.8.1.2
