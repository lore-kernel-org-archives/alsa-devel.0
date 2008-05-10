From: Sjoerd Simons <sjoerd@luon.net>
Subject: Re: [alsa-devel] Pulseaudio alsa configure hook
Date: Sat, 10 May 2008 21:46:25 +0200
Message-ID: <20080510194625.GA5558@spring.luon.net>
References: <20080427203709.GA13496@spring.luon.net>
	<s5hiqxzuxev.wl%tiwai@suse.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
Content-Disposition: inline
In-Reply-To: <s5hiqxzuxev.wl%tiwai@suse.de>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: Takashi Iwai <tiwai@suse.de>
Cc: pulseaudio-discuss@mail.0pointer.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2008 at 06:20:40PM +0200, Takashi Iwai wrote:
> At Sun, 27 Apr 2008 22:37:09 +0200,
> >   The attached patch extends the alsa pulse plugin set with a alsa
> >   configuration hook. Allowing one to specify some configuration parameters
> >   that only come into effect when pulseaudio is running.
> > 
> >   For example a configution file like:
> > 
> >     @hooks [ {
> >        func on_pulse_is_running
> >          pcm.!default { type pulse }
> >          ctl.!default { type pulse }
> >        }
> >    ]
> > 
> >   will redirect the default alsa pcm and ctl to pulse iff pulse is running.
> >   (Assuming you defined the hook function correctly ofcourse)

> This looks pretty interesting.
> I forgot that this kind of stuff can be also a plugin :)
> 
> Applied to HG tree now.

Thanks :).. Unfortunately some more testing revealed some issues with it,
specifically if pulse is running your complete config is replaced the bits in
the on_pulse_is_running directive. Which might not be what one actually wants :)

I couldn't find a proper solution for this. So i've changed the code to
optionally load config files. Just like the load hook does. Actually i just
optionally call the snd_config_hook_load function, but that's not actually in
the alsa API....

Also it now decides pulse is running as soon as the authorizing step begins
(just after the actually connection is setup), which should save some
round-trips and overhead.

Updated patch attached :)

  Sjoerd
-- 
For fast-acting relief, try slowing down.

--n8g4imXOkfNTN/H1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-pulse-conf.patch"

diff -r 8b8cd8912f67 pulse/conf_pulse.c
--- a/pulse/conf_pulse.c	Wed Apr 30 20:18:15 2008 +0200
+++ b/pulse/conf_pulse.c	Sat May 10 21:28:23 2008 +0200
@@ -26,14 +26,19 @@
 #include <pulse/pulseaudio.h>
 
 
+/* Not actually part of the alsa api....  */
+extern int
+snd_config_hook_load (snd_config_t *root, snd_config_t *config,
+  snd_config_t **dst, snd_config_t *private_data);
+
 int
-conf_pulse_hook_on_is_running (snd_config_t *root, snd_config_t *config,
+conf_pulse_hook_load_if_running (snd_config_t *root, snd_config_t *config,
     snd_config_t **dst, snd_config_t *private_data) {
-  snd_config_t *n = NULL;
   pa_mainloop *loop = NULL;
   pa_context *context = NULL;
   int ret = 0, err, state;
 
+  *dst = NULL;
 
   /* Defined if we're called inside the pulsedaemon itself */
   if (getenv("PULSE_INTERNAL") != NULL)
@@ -65,12 +70,12 @@
       goto out;
 
     state = pa_context_get_state(context);
-  } while (state < PA_CONTEXT_READY);
+  } while (state < PA_CONTEXT_AUTHORIZING);
 
-  if (state != PA_CONTEXT_READY)
+  if (state > PA_CONTEXT_READY)
     goto out;
 
-  ret = snd_config_expand(config, root, NULL, private_data, &n);
+  ret = snd_config_hook_load(root, config, dst, private_data);
 
 out:
   if (context != NULL)
@@ -79,10 +84,8 @@
   if (loop != NULL)
     pa_mainloop_free(loop);
 
-  *dst = n;
-
   return ret;
 }
 
-SND_DLSYM_BUILD_VERSION(conf_pulse_hook_on_is_running,
+SND_DLSYM_BUILD_VERSION(conf_pulse_hook_load_if_running,
   SND_CONFIG_DLSYM_VERSION_HOOK);

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@mail.0pointer.de
https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss

--n8g4imXOkfNTN/H1--
