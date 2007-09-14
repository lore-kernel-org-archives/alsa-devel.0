From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA: snd_pcm_avail_update
Date: Fri, 14 Sep 2007 12:26:26 -0400
Message-ID: <20070914122626.49366db3.alsauser@pragmasoft.com>
References: <20070913185555.35445b93.alsauser@pragmasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7.server.rpi.edu (smtp7.server.rpi.edu [128.113.2.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D0C0244FB
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 18:21:16 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp7.server.rpi.edu (8.13.1/8.13.1) with SMTP id l8EGLDoD018147
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 12:21:14 -0400
In-Reply-To: <20070913185555.35445b93.alsauser@pragmasoft.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Sep 2007 18:55:55 -0400
"J. Scott Merritt" <alsauser@pragmasoft.com> wrote:

> Using salsa-lib-0.0.11, cross-compiling to ARM ...
> 
> Despite my best efforts, snd_pcm_avail_update is always returning
> "broken pipe".  I have checked the pcm_state of the Capture Handle
> just before snd_pcm_avail_update and it is "RUNNING'.  But immediately
> after snd_pcm_avail_update it always returns "XRUN".  Furthermore,
> this same sequence seems to work properly with the standard ALSA-Lib.
> 
> Test program is attached.  Any suggestions appreciated.
> 
> Thanks, Scott.
> 

After further investigation ... it appears that snd_pcm_open() in
salsa-lib-0.0.11:pcm.c is not properly recording/initializing the
pcm->stream field.
