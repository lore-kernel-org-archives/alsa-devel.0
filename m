From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: aoss patch [against cvs?]
Date: Tue, 27 Jul 2004 18:43:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040727184308.3055b600@mango.fruits.de>
References: <20040723164816.622682b5@mango.fruits.de>
	<s5hacxl5zii.wl@alsa2.suse.de>
	<20040727174522.6fb1bca0@mango.fruits.de>
	<s5hn01l4eqk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn01l4eqk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jul 2004 18:05:55 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Ok, point taken.
> Your patch was applied to cvs now.

I have to revisit this patch again to bring this device file name
checking from alsa-oss.c in sync with 

static int oss_mixer_open(int card, int device, int oflag, mode_t mode
ATTRIBUTE_UNUSED);

in mixer.c and 

int lib_oss_pcm_open(const char *file, int oflag, ...);

in pcm.c. Expect patch in the next few days.. I have to meditate over
this a bit first.

Florian Schmidt



-- 
Palimm Palimm!
http://affenbande.org/~tapas/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
