From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: libasound2: snd_device_name_hint() wrongly calls
	snd_config_delete()
Date: Fri, 23 Oct 2009 18:29:16 +0200
Message-ID: <20091023162916.GA2933@aragorn.home.lxtec.de>
References: <1254616484.15064.58.camel@dark-knight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250]) by alsa0.perex.cz (Postfix) with ESMTP id DB840243B2
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Oct 2009 18:29:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254616484.15064.58.camel@dark-knight>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>, 549531@bugs.debian.org
Cc: alsa-devel@alsa-project.org, control@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

forwarded 549531 alsa-devel@alsa-project.org
thanks

This looks more like a general problem and shouldn't be solved
distribution specific so request for help to the alsa developers.

Elimar

* John Lindgren [091003 20:34 -0400]
> Package: libasound2
> Version: 1.0.21a-1
> Severity: normal
> Tags: patch
> 
> Symptoms
> --------
> 
> This bug first showed up because of a new ALSA output plugin for
> Audacious audio player:
> 
>         http://jira.atheme.org/browse/AUDPLUG-77#action_10640
>         
> Essentially, any call to snd_device_name_hint() causes later calls to
> snd_pcm_open() to fail with messages like these:
> 
>         ALSA lib conf.c:4600:(snd_config_expand) Unknown parameters CARD=Live,DEV=0 
>         ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM rear:CARD=Live,DEV=0
> 
> This happens only for PCMs defined in ALSA config files (such as the
> ones under /usr/share/alsa/cards), not for "default" or "hw:0,0"-style.
> It does not seem to depend on a particular sound card. It can be
> reproduced without Audacious by adding a call to pcm_list() before the
> call to snd_pcm_open() in aplay.c from the alsa-utils package:
> 
>         $ ./aplay -D front:CARD=ICH6,DEV=0 Test.wav
>         default:CARD=ICH6
>             Intel ICH6, Intel ICH6
>             Default Audio Device
>         front:CARD=ICH6,DEV=0
>             Intel ICH6, Intel ICH6
>             Front speakers
>         surround40:CARD=ICH6,DEV=0
>             Intel ICH6, Intel ICH6
>             4.0 Surround output to Front and Rear speakers
>         surround41:CARD=ICH6,DEV=0
>             Intel ICH6, Intel ICH6
>             4.1 Surround output to Front, Rear and Subwoofer speakers
>         surround50:CARD=ICH6,DEV=0
>             Intel ICH6, Intel ICH6
>             5.0 Surround output to Front, Center and Rear speakers
>         surround51:CARD=ICH6,DEV=0
>             Intel ICH6, Intel ICH6
>             5.1 Surround output to Front, Center, Rear and Subwoofer speakers
>         iec958:CARD=ICH6,DEV=0
>             Intel ICH6, Intel ICH6 - IEC958
>             IEC958 (S/PDIF) Digital Audio Output
>         null
>             Discard all samples (playback) or generate zero samples (capture)
>         ALSA lib conf.c:4600:(snd_config_expand) Unknown parameters CARD=ICH6,DEV=0
>         ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM front:CARD=ICH6,DEV=0
>         aplay: main:610: audio open error: Invalid argument
>         
> Diagnosis
> ---------
> 
> try_config(), called by snd_device_name_hint(), calls
> snd_config_search_definition() at namehint.c line 243 and
> snd_config_search_alias_hooks() at line 339, then calls
> snd_config_delete() on the returned nodes at lines 331 and 383.  This
> was probably meant to prevent leaking memory returned by the search
> functions, but in fact it removes information from the config that is
> needed by later calls, such as snd_pcm_open.  Hence, snd_pcm_open
> behaves as though devices like "front" and "rear" do not exist.
> 
> I have attached a patch for aplay.c to reproduce the problem and a patch
> for namehint.c to fix it.  One side effect of the fix (on my system at
> least) is that two "null" devices are now listed by "aplay -L" and in
> Audacious.
> 
> Peace,
> John Lindgren
> 
> 
> -- System Information:
> Debian Release: squeeze/sid
>   APT prefers testing
>   APT policy: (500, 'testing')
> Architecture: i386 (i686)
> 
> Kernel: Linux 2.6.30-1-686 (SMP w/1 CPU core)
> Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
> Shell: /bin/sh linked to /bin/dash
> 
> Versions of packages libasound2 depends on:
> ii  libc6                         2.9-25     GNU C Library: Shared libraries
> 
> libasound2 recommends no packages.
> 
> Versions of packages libasound2 suggests:
> pn  libasound2-plugins            <none>     (no description available)
> 
> -- no debconf information

> --- aplay.0.c	2009-08-31 11:13:36.000000000 -0400
> +++ aplay.c	2009-10-03 19:54:43.000000000 -0400
> @@ -603,6 +603,8 @@
>  		goto __end;
>  	}
>  
> +	pcm_list();
> +
>  	err = snd_pcm_open(&handle, pcm_name, stream, open_mode);
>  	if (err < 0) {
>  		error(_("audio open error: %s"), snd_strerror(err));

> --- namehint.0.c	2009-09-09 08:34:54.000000000 -0400
> +++ namehint.c	2009-10-03 17:39:23.000000000 -0400
> @@ -328,7 +328,6 @@
>  	if (snd_config_search(cfg1, "slave", &cfg) >= 0 &&
>  	    snd_config_search(cfg, base, &cfg1) >= 0)
>  	    	goto __hint;
> -	snd_config_delete(res);
>  	res = NULL;
>  	if (strchr(buf, ':') != NULL)
>  		goto __ok;
> @@ -379,8 +378,6 @@
>  	      	err = hint_list_add(list, buf, buf1);
>  	}
>        __skip_add:
> -      	if (res)
> -	      	snd_config_delete(res);
>  	if (buf1)
>  		free(buf1);
>        	free(buf);

> _______________________________________________
> Pkg-alsa-devel mailing list
> Pkg-alsa-devel@lists.alioth.debian.org
> http://lists.alioth.debian.org/mailman/listinfo/pkg-alsa-devel


-- 
  It's a good thing we don't get all 
  the government we pay for.
