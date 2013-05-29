From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/3] lx6464es: dump MAC in standard form
Date: Wed, 29 May 2013 14:31:07 +0300
Message-ID: <1369827067.29283.237.camel@smile>
References: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1369821802-2308-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <s5hehcq6qhw.wl%tiwai@suse.de> <1369825257.29283.229.camel@smile>
 <s5hy5ay59qc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ECF2261A96
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 13:31:11 +0200 (CEST)
In-Reply-To: <s5hy5ay59qc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-05-29 at 13:03 +0200, Takashi Iwai wrote:

> > > > -	sprintf(card->shortname, "LX6464ES %02X.%02X.%02X.%02X.%02X.%02X",
> > > > -		chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
> > > > -		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
> > > > +	sprintf(card->shortname, "LX6464ES %pM", chip->mac_address);
> > > 
> > > This will change from the upper to the lower case, thus it'll lead to
> > > an incompatible name string, unfortunately.
> > 
> > Who is the user of this string?
> 
> It's exposed to the user-space via ioctl and it can be used as an id
> string.  So this will break user-space compatibility.

MAC is theoretically set of arbitrary 6 bytes.
Only what I can see here is the difference between '.' and ':' as a
delimiter. But the MAC address form is defined in IEEE 802 standards.

Anyway, I am okay if you reject this one.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
