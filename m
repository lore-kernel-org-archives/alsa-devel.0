From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] alsa-lib: snd_device_name_hint misbehaving
Date: Mon, 02 Nov 2009 13:12:21 -0500
Message-ID: <1257185541.1937.17.camel@dark-knight>
References: <1257128586.16837.29.camel@dark-knight>
	<alpine.LNX.2.00.0911020718220.5500@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FFE9243B2
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 19:12:24 +0100 (CET)
Received: by ywh28 with SMTP id 28so4777336ywh.16
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 10:12:24 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911020718220.5500@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-11-02 at 07:21 +0100, Jaroslav Kysela wrote:
> On Sun, 1 Nov 2009, John Lindgren wrote:
> 
> > * Remove erroneous snd_config_delete calls that cause later calls to
> > snd_pcm_open to fail.
> 
> It does not look good. Have you checked with valgrind if there are no 
> memory leaks?

You're making the same mistake that the original author of the code
made.  snd_config_delete is not a call to free memory; it is a call to
remove sections of the loaded configuration.  The configuration nodes
that were being passed to snd_config_delete were returned by
snd_config_search, which returns direct pointers to the actual nodes in
the configuration.  It does no memory duplication.

> Please, split your changes to single patches. Thanks.

I will do so when I have the time to learn Git a little better.  (I
normally use Mercurial).

John Lindgren
