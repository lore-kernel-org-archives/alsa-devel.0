From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 7/7] sound/usb: Update ALSA driver to use Managed Media
 Controller API
Date: Mon, 20 Jul 2015 11:47:46 +0300
Message-ID: <20150720084746.GH5422@mwanda>
References: <cover.1436917513.git.shuahkh@osg.samsung.com>
 <656c6578247d86262b7999d85db9f9995058eb36.1436917513.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <656c6578247d86262b7999d85db9f9995058eb36.1436917513.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, tiwai@suse.de, perex@perex.cz, crope@iki.fi, sakari.ailus@linux.intel.com, arnd@arndb.de, stefanr@s5r6.in-berlin.de, ruchandani.tina@gmail.com, chehabrafael@gmail.com, prabhakar.csengg@gmail.com, chris.j.arges@canonical.com, agoode@google.com, pierre-louis.bossart@linux.intel.com, gtmkramer@xs4all.nl, clemens@ladisch.de, daniel@zonque.org, vladcatoi@gmail.com, misterpib@gmail.com, damien@zamaudio.com, pmatilai@laiskiainen.org, takamichiho@gmail.com, normalperson@yhbt.net, bugzilla.frnkcg@spamgourmet.com, joe@oampo.co.uk, calcprogrammer1@gmail.com, jussi@sonarnerd.net, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2015 at 06:34:06PM -0600, Shuah Khan wrote:
> +		ret = media_entity_setup_link(link, flags);
> +		if (ret) {
> +			dev_err(mctl->media_dev->dev,
> +				"Couldn't change tuner link",
> +				"%s->%s to %s. Error %d\n",

Add a space after "link".

				"Couldn't change tuner link ",
				"%s->%s to %s. Error %d\n",

regards,
dan carpenter
