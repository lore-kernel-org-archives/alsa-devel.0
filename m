From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] RFC for snd-usb: rework usb endpoint
	logic
Date: Wed, 02 Nov 2011 09:27:30 +0100
Message-ID: <4EB0FEF2.9000205@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<4EAE96BC.6060605@gmail.com> <s5haa8fn7cg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 299BD10381C
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 09:27:42 +0100 (CET)
Received: by faao24 with SMTP id o24so171469faa.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Nov 2011 01:27:40 -0700 (PDT)
In-Reply-To: <s5haa8fn7cg.wl%tiwai@suse.de>
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
Cc: blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 11/01/2011 05:19 PM, Takashi Iwai wrote:
 > The overall design looks good to me.  Nice work!
 > A few nitpicking:

Thanks for your review!

 > - No need for check of activated flags at starting streams?

Such a condition would be a bug in the driver. But I'll add a check.

 > - Better to clear subs->data_endpoint&  co at closing.

Jup.

 > - There might be unbalances when deactivate_endpoints() isn't called
 >    in prepare callback before activate_endpoints().  The apps may call
 >    like
 > 	open ->  hw_params ->  prepare ->  hw_params ->  prepare ->  trigger
 >    and
 > 	trigger (stop) ->  prepare ->  trigger (start)
 >    So, be careful about refcounting and active flags.

Hmm, I don't think I follow here. snd_usb_endpoint_{de,}activate() don't 
actually touch the refcounts but act upon the "activated" flag, and 
snd_usb_endpoint_{start,stop}() will touch the refcounts only. Hence, an 
unbalanced call to activate() would basically be a noop. Do I miss your 
point?

 > And, yes, the protection for snd_usb_add_endpoint() would be really
 > needed for concurrent access.  The card-global mutex would be enough.

Ok. However, there is actually no card-global mutex for that purpose, 
right? I'll add one :)


Thanks,
Daniel
