From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: LADSPA plugin segfault patch
Date: Sat, 14 Jun 2003 09:33:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306140931470.13576-100000@pnote.perex-int.cz>
References: <3EEA478A.8020606@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EEA478A.8020606@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Honeywell <davidh@pianodisc.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Jun 2003, David Honeywell wrote:

> I have been experimenting with LADSPA plugins available from 
> http://plugin.org.uk/ and other sources.  I found that many of the 
> plugins caused a segfault during pcm playback, while some did not.  I 
> traced the problem to LADSPA plugins which do not have an activate() 
> function.  Apparently this function can be present, or set to NULL.
> 
> I found that whenever activate() or deactivate() are called in 
> pcm_ladspa.c, a sanity check is performed before calling the function. 
> EXCEPT in one instance.  When I added the sanity check to that instance, 
> the segfaults disappeared and all of the plugins that I tried worked. 
> Here is a patch for alsa-lib/src/pcm/pcm_ladspa.c:
> 
> 
> --- pcm_ladspa.orig	2003-06-13 13:34:58.000000000 -0700
> +++ pcm_ladspa.c	2003-06-13 13:32:02.000000000 -0700
> @@ -412,7 +412,8 @@
>   				return -EINVAL;
>   			}
>   			list_add_tail(&instance->list, &plugin->instances);
> -			plugin->desc->activate(instance->handle);
> +			if (plugin->desc->activate)
> +			  plugin->desc->activate(instance->handle);
>   			if (plugin->policy == SND_PCM_LADSPA_POLICY_DUPLICATE) {
>   				err = snd_pcm_ladspa_connect_plugin_duplicate(plugin, 
> &plugin->input, instance, idx);
>   				if (err < 0) {
> 

Thanks. Added to CVS.

> There's one other problem that I haven't been able to solve yet.  When I 
> use the latest ALSA library, I get error messages that complain about 
> the version whenever I try to play pcm through the plugin:
> 
> ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for 
> symbol ladspa_descriptor
> 
> Compiling --with-versioned= yes or no makes no difference in this case.
> The only way I have been able to get around this problem is to use an 
> old ALSA library (I'm currently using 0.9.0rc6).  I have tried many 
> versions of the library.  The problem seems to have started with CVS 
> version 1.11 of pcm_ladspa.c.  Version 1.10 uses dlopen(), dlclose(), 
> and dlsym(), while version 1.11 uses snd_dlopen(), snd_dlclose(), and 
> snd_dlsym().  This appears to be the only difference between the two 
> versions.  Any help on this issue would be greatly appreciated, as I'd 
> like to use the most up-to-date library.

Using snd_dl*() function in LADSPA is broken. They do own versioning for 
internal functions which is not applicable to external code like LADSPA 
plugins. It should be fixed in CVS. Thank you for notice.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
