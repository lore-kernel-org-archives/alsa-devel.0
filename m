From: Will Wagner <will_wagner@carallon.com>
Subject: Re: softvol plugin question
Date: Wed, 07 May 2008 19:25:46 +0100
Message-ID: <4821F42A.6020601@carallon.com>
References: <4821AFFA.7010401@carallon.com> <4821E43A.5050402@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 78B5024482
	for <alsa-devel@alsa-project.org>;
	Wed,  7 May 2008 20:27:44 +0200 (CEST)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000229217.msg
	for <alsa-devel@alsa-project.org>; Wed, 07 May 2008 19:27:15 +0100
In-Reply-To: <4821E43A.5050402@tet.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gustavo da Silva Serra wrote:
> I had this problem with alsamixer itself. It doesn't appear until I call 
> "alsactl restore". To automate I added this line to /etc/rc.local.
> 

Thanks, that fixed it.

As an aside I had to patch alsa-utils/alsactl/names.c to make it work 
with my alsa lib as I have disabled midi & seq support. The patch is 
below, the problem with it is that alsa-lib does not expose in a header 
anywhere what is enabled/disabled (alsa-lib/include/config.h appears to 
be a private header that does not get installed).

--- alsa-utils-1.0.16/alsactl/names.c	2008-05-07 19:03:59.000000000 +0100
+++ alsa-utils-1.0.16/alsactl/names.c.new	2008-05-07 19:03:53.000000000 
+0100
@@ -282,6 +282,7 @@ static int probe_pcm(snd_config_t *confi
  	return 0;
  }

+#ifdef BUILD_RAWMIDI
  static int probe_rawmidi_virtual(snd_config_t *config,
  				 const char *name, const char *comment)
  {
@@ -411,6 +412,7 @@ static int probe_rawmidi(snd_config_t *c
  		return err;
  	return 0;
  }
+#endif // BUILD_RAWMIDI

  static int probe_timers(snd_config_t *config)
  {
@@ -473,6 +475,7 @@ static int probe_timer(snd_config_t *con
  	return 0;
  }

+#ifdef BUILD_SEQ
  static int probe_seq(snd_config_t *config)
  {
  	int err;
@@ -492,15 +495,20 @@ static int probe_seq(snd_config_t *confi
  		return err;
  	return 0;
  }
+#endif

  typedef int (probe_fcn)(snd_config_t *config);

  static probe_fcn * probes[] = {
  	probe_ctl,
  	probe_pcm,
+#ifdef BUILD_RAWMIDI
  	probe_rawmidi,
+#endif
  	probe_timer,
+#ifdef BUILD_SEQ
  	probe_seq,
+#endif
  	NULL
  };



-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Senior Project Engineer                  Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------
