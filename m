From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Wed, 24 Feb 2016 17:18:58 +0100
Message-ID: <3238725.1iS2dg6EkI@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5h8u2j6749.wl-tiwai@suse.de> <s5h1t8b65n7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id C43162606F6
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 17:19:19 +0100 (CET)
In-Reply-To: <s5h1t8b65n7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 17 February 2016 10:35:40 Takashi Iwai wrote:
> On Wed, 17 Feb 2016 10:03:50 +0100,
> +	const char *id;
> +#ifdef CONFIG_SND_JACK_INPUT_DEV
> +	struct input_dev *input_dev;
>  	int registered;
>  	int type;
> -	const char *id;
>  	char name[100];
>  	unsigned int key[6];   /* Keep in sync with definitions above */
> +#endif /* CONFIG_SND_JACK_INPUT_DEV */
>  	void *private_data;
>  	void (*private_free)(struct snd_jack *);
>  };

I got a build error from this today, as the trace event tries to print
the jack "name" field. I've managed to get it to build again by printing
the "id" field in place of the "name". The name is normally assigned
from id in snd_jack_dev_register using

        snprintf(jack->name, sizeof(jack->name), "%s %s",
                 card->shortname, jack->id);

but that code is not called here at all. My patch will slightly
alter the output as a consequence, but I don't know if this change
is critical or not.

	Arnd

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 317a1ed2f4ac..9130dd5a184a 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -231,13 +231,13 @@ TRACE_EVENT(snd_soc_jack_report,
 	TP_ARGS(jack, mask, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		jack->jack->name	)
+		__string(	name,		jack->jack->id		)
 		__field(	int,		mask			)
 		__field(	int,		val			)
 	),
 
 	TP_fast_assign(
-		__assign_str(name, jack->jack->name);
+		__assign_str(name, jack->jack->id);
 		__entry->mask = mask;
 		__entry->val = val;
 	),
@@ -253,12 +253,12 @@ TRACE_EVENT(snd_soc_jack_notify,
 	TP_ARGS(jack, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		jack->jack->name	)
+		__string(	name,		jack->jack->id		)
 		__field(	int,		val			)
 	),
 
 	TP_fast_assign(
-		__assign_str(name, jack->jack->name);
+		__assign_str(name, jack->jack->id);
 		__entry->val = val;
 	),
 
