From: Gerd Knorr <kraxel@suse.de>
Subject: Re: Problem with Avermedia 771
Date: Wed, 20 Oct 2004 17:27:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041020152756.GA24478@bytesex>
References: <416ED29A.7060200@qanu.de> <20041015101119.GH3866@bytesex> <Pine.LNX.4.58.0410151254140.20968@pnote.perex-int.cz> <20041018130114.GA5476@bytesex> <s5h3c0cjd24.wl@alsa2.suse.de> <20041019161340.GA12001@bytesex> <s5hzn2hh735.wl@alsa2.suse.de> <s5hy8i1h6k8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy8i1h6k8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Jaroslav Kysela <perex@suse.cz>, Clemens Ladisch <clemens@ladisch.de>, Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> +	if (pci_id->driver_data & DRIVER_DEFAULT_ENTRY) {
> +		if (! load_all)
> +			return -ENODEV;
> +	}

A (temporary) printk here would probably be useful so people with
working but not-yet whitelisted cards know what is going on and can (a)
report the IDs and (b) get the card going using the new insmod option.

Otherwise the patch looks fine to me.

  Gerd



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
