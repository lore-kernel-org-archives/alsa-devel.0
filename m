From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Tue, 16 Feb 2016 23:08:13 +0100
Message-ID: <3395859.dhsfOsmVIe@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hr3gc60ph.wl-tiwai@suse.de> <2706488.VpKveMVPGI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 816532657B8
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 23:08:32 +0100 (CET)
In-Reply-To: <2706488.VpKveMVPGI@wuerfel>
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

On Tuesday 16 February 2016 18:26:09 Arnd Bergmann wrote:
> >                 return err;
> >         per_pin->acomp_jack = jack;
> > -       jack->private_data = per_pin;
> > -       jack->private_free = free_acomp_jack_priv;
> > +       if (jack) {
> > +               jack->private_data = per_pin;
> > +               jack->private_free = free_acomp_jack_priv;
> > +       }
> >         return 0;
> >  }
> > 
> Looks good to me.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Actually, on second thought, there is one notable downside
of this approach: 'jack' is guaranteed to be NULL here, so gcc
won't produce a warning if another driver makes the same mistake:

By default, we only get a warning for uses of uninitialized
variables, but not those that are known to be NULL. I think
some compiler warnings are able to warn about that too, but I
forgot the details.

	Arnd
