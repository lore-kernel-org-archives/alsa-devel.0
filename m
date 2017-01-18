From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v4 1/2] ucm: Load device-specific
 configuration file based on the card long name
Date: Wed, 18 Jan 2017 03:52:03 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A1C6C6@shsmsx102.ccr.corp.intel.com>
References: <cover.1484381554.git.mengdong.lin@linux.intel.com>
 <d8b6cfb75c226c59f4ca6e15c419eb2955b582fa.1484381554.git.mengdong.lin@linux.intel.com>
 <s5hinpgivbp.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F881A19C50@shsmsx102.ccr.corp.intel.com>
 <s5hk29vxp64.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 04773266BEB
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 04:52:08 +0100 (CET)
In-Reply-To: <s5hk29vxp64.wl-tiwai@suse.de>
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, January 16, 2017 6:41 PM
> To: Lin, Mengdong <mengdong.lin@intel.com>
> Cc: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
> liam.r.girdwood@linux.intel.com
> Subject: Re: [PATCH v4 1/2] ucm: Load device-specific configuration file based
> on the card long name
> 
> On Sun, 15 Jan 2017 11:01:15 +0100,
> Lin, Mengdong wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Sunday, January 15, 2017 4:25 PM
> > >
> > > On Sat, 14 Jan 2017 09:23:55 +0100,
> > > mengdong.lin@linux.intel.com wrote:
> > > >
> > > > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> > > >
> > > > Intel DSP platform drivers are used by many different devices. For
> > > > user space to differentiate them, ASoC machine drivers may use the
> > > > DMI info
> > > > (vendor-product-version-board) as card long name. Possible card
> > > > long names
> > > > are:
> > > > DellInc.-XPS139343-01-0310JH
> > > > ASUSTeKCOMPUTERINC.-T100TA-1.0-T100TA
> > > > Circuitco-MinnowboardMaxD0PLATFORM-D0-MinnowBoardMAX
> > > > ...
> > > >
> > > > And user space can define configuration files like
> > > > longname\longname.conf for a specific device.
> > >
> > > Do you mean a file name containing a backslash?
> > > I didn't find the relevant code in your patch...
> >
> > No, the file name doesn't contain a backslash. It means we're using the
> card long name as both the directory name that contains the UCM config file
> and the name of the config file itself.
> > E.g. for the laptop Dell XPS 13, UCM will try to find a directory "DellInc.-
> XPS139343-01-0310JH", and then find the file " DellInc.-XPS139343-01-
> 0310JH.conf" under the directory. If it cannot find the this file, it will fall back
> to open file "broadwell-rt286.conf" under directory "broadwell-rt286".
> 
> Ah, a backslash as on DOS.  Use a slash for Linux instead :)
> 
> 
> Takashi

Sorry, I fixed this in v6. Now the kernel side patches have been applied to ASoC so there is no dependency now.

Thanks
Mengdong
