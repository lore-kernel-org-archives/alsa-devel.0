From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Remove depop delay for suspend and resume
Date: Fri, 29 Nov 2013 09:09:52 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141FD2C@SHSMSX101.ccr.corp.intel.com>
References: <F59E396CBAC34485AD04AEDF69643CB9@realtek.com.tw>
 <s5hk3frg0ck.wl%tiwai@suse.de>
 <AC74BF9D54F2441085B7DF5480D68E29@realtek.com.tw>
 <F46914AEC2663F4A9BB62374E5EEF8F80141FC64@SHSMSX101.ccr.corp.intel.com>
 <s5h38mffwg1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEB42654E9
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 10:10:00 +0100 (CET)
In-Reply-To: <s5h38mffwg1.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, November 29, 2013 4:23 PM


> > Thank you for the info! I only tested Baytrail-M platform.
> >
> > Is it possible to add a flag and set the flag a in board-specific fixup?
> 
> Yes, feel free to hack struct alc_spec.

Okay. I'll modify the patch as you suggested, and add a board fixup for Baytrail.

Thanks
Mengdong

> > > > At Fri, 29 Nov 2013 10:48:20 +0800, Kailang wrote:
> > > >>
> > > >> Hi Takashi,
> > > >>
> > > >> Intel test alc262.
> > > >> They find the suspend and resume time were > 50ms.
> > > >> So, I delete the delay for alc_eapd_shutup and alc_resume.
> > > >> If we want to have depop functions, we will follow like alc283.
> > > >
> > > > Which delay value to take is pretty specific to machine.  Removing
> > > > delay will likely cause problem on other machines.
> > > >
> > > > So, if we'd remove delays, do it only for tested machines, not do
> > > > blindly to all machines using the same codec chips.  The pop noise
> > > > isn't only determined by a codec chip but rather influenced by the
> > > > whole hardware analog design.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > > >
> > > > ------Please consider the environment before printing this e-mail.
> >
