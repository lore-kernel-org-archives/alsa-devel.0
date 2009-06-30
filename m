From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: External PCM hook SO is dlclosed after
	calling	install, making it hard to have hooks in it
Date: Tue, 30 Jun 2009 10:20:54 +0400
Message-ID: <20090630062054.GE23025@home.pavel.comp>
References: <20090629221101.GD23025@home.pavel.comp>
	<s5hd48mi76e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oJ71EGRlYNjSvfq7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FA0010385C
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 08:21:47 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 13so617637fge.21
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 23:21:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hd48mi76e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Joerg Reisenweber <joerg@openmoko.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2009 at 08:09:45AM +0200, Takashi Iwai wrote:
> At Tue, 30 Jun 2009 02:11:01 +0400,
> Paul Fertser wrote:
> > I've tried to implement an external shared object to be able to
> > execute arbitrary functions on PCM device opening and closing. After
> > quite some source code reading i had an almost working but segfaulting
> > example. This segfault is because snd_dlclose is called right after
> > calling a hook install function and therefore i can't snd_pcm_hook_add
> > functions from the same shared object. To me it looks like a bug but
> > probably i just don't see how this functionality is intended to be
> > used. Takashi, git-blame showed that it's you who stuffed this dlclose
> > call that bothers me ;)
> 
> Well, right now, a plugin is designed to be bound with a single PCM
> instance.  That's why dlcolse is called in snd_pcm_close(). 

It looks like we're talking about different things. You seem to be
talking about external PCM plugins, i'm talking about external functions
for the "hook" PCM plugin. The code i question is in pcm/pcm_hooks.c
in function snd_pcm_hook_add_conf:

        if (err >= 0) {
                if (args && snd_config_get_string(args, &str) >= 0) {
                        err = snd_config_search_definition(root,
                "hook_args", str, &args);
                        if (err < 0)
                                SNDERR("unknown hook_args %s", str);
                        else
                                err = install_func(pcm, args);
                        snd_config_delete(args);
                } else
                        err = install_func(pcm, args);
                snd_dlclose(h);
        }

> Can you give your code to grasp more implementation images?

Rough sketch attached.

> > We're working on audio subsystem for OpenMoko Freerunner. It's an idea
> > of Joerg Reisenweber to have virtual alsa devices for every reasonable
> > use-case (like dedicated device for stereout, dedicated device for
> > recording from gsm etc), for that we need a hook on every device
> > opening and closing mostly to set up routing inside WM8753
> > codec. ctl_elems is not enough because we need a more complex locking
> > scheme (with priorities, some kind of callbacks to the apps using
> > particular devices etc) and other flexibility.
> 
> To hook off snd_pcm_open and snd_pcm_close, you could use LD_PRELOAD.
> But, a plugin sounds more interesting.

Much more, i'd say.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testhook.c"

#include <alsa/asoundlib.h>
#include <alsa/conf.h>
#include <alsa/pcm.h>
#include <dlfcn.h>
#include <stdio.h>

snd_config_t *conf_copy;

static int snd_pcm_hook_testhook_hw_params(snd_pcm_hook_t *hook)
{
	const char *str;
        snd_config_t *h = snd_pcm_hook_get_private(hook);
	snd_config_t *s;
	snd_config_search(h, "hw", &s);
	snd_config_get_string(s, &str);
	fprintf(stderr, "testhook: hw_params, %s\n", str);
        return 0;
}

static int snd_pcm_hook_testhook_hw_free(snd_pcm_hook_t *hook)
{
	const char *str;
        snd_config_t *h = snd_pcm_hook_get_private(hook);
	snd_config_t *s;
	snd_config_search(h, "close", &s);
	snd_config_get_string(s, &str);
	fprintf(stderr, "testhook: hw_free, %s\n", str);
        return 0;
}

static int snd_pcm_hook_testhook_close(snd_pcm_hook_t *hook)
{
	fprintf(stderr, "testhook: close\n");
        return 0;
}

int _snd_pcm_hook_testhook_install(snd_pcm_t *pcm, snd_config_t *conf)
{
	int err;
        snd_pcm_hook_t *h_hw_params = NULL, *h_hw_free = NULL, *h_close = NULL;

	snd_config_copy(&conf_copy, conf);

//	dlopen("testhook.so", RTLD_NOW);

        err = snd_pcm_hook_add(&h_hw_params, pcm, SND_PCM_HOOK_TYPE_HW_PARAMS,
                               snd_pcm_hook_testhook_hw_params, conf_copy);
        if (err < 0)
                goto _err;
        err = snd_pcm_hook_add(&h_hw_free, pcm, SND_PCM_HOOK_TYPE_HW_FREE,
                               snd_pcm_hook_testhook_hw_free, conf_copy);
        if (err < 0)
                goto _err;
        err = snd_pcm_hook_add(&h_close, pcm, SND_PCM_HOOK_TYPE_CLOSE,
                               snd_pcm_hook_testhook_close, NULL);
	return 0;
 _err:
        if (h_hw_params)
                snd_pcm_hook_remove(h_hw_params);
        if (h_hw_free)
                snd_pcm_hook_remove(h_hw_free);
        if (h_close)
                snd_pcm_hook_remove(h_close);
        return err;
}

SND_DLSYM_BUILD_VERSION(_snd_pcm_hook_testhook_install, SND_PCM_DLSYM_VERSION);


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--oJ71EGRlYNjSvfq7--
