From: "Lu, Han" <han.lu@intel.com>
Subject: Re: bat: naming conflict in distribution packages
	with	Bareos/Bacula
Date: Tue, 12 Jan 2016 02:53:21 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D379AAD@SHSMSX101.ccr.corp.intel.com>
References: <n5e2br$fdp$1@ger.gmane.org> <s5hh9ikyx25.wl-tiwai@suse.de>
 <1452527626.2473.28.camel@loki> <56940A66.4040201@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A4C32260455
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 03:53:30 +0100 (CET)
In-Reply-To: <56940A66.4040201@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: J6rg Steffens <joerg.steffens@bareos.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Clemens Ladisch [mailto:clemens@ladisch.de]
> Sent: Tuesday, January 12, 2016 4:03 AM
> To: Liam Girdwood; Takashi Iwai
> Cc: J6rg Steffens; alsa-devel@alsa-project.org; Gautier, Bernard; Lu, Han
> Subject: Re: [alsa-devel] bat: naming conflict in distribution packages with
> Bareos/Bacula
> 
> Liam Girdwood wrote:
> > On Mon, 2016-01-11 at 16:07 +0100, Takashi Iwai wrote:
> >> J6rg Steffens wrote:
> >>> alsa-utils as well as bareos-bat (as well a some Bacula packages)
> >>> all contain a program called /usr/bin/bat, which causes conflicts on
> >>> various distributions ("basic audio tester" vs "bareos administration tool"
> >>> ("bacula administration tool")).
> >>
> >> [...]
> >> OTOH, if we all agree with renaming to something less likely
> >> conflicting, I'm all fine with it.
> >
> > What about prefixing "alsa" or "a" to to bat ?
> 
> Why not calling it basic-audio-test (like speaker-test)?
> 
> 
> Regards,
> Clemens

I prefer "alsabat" since there are many acronym "bat" in code and document already,
"basic-audio-test" is more clear but the name "alsabat" keeps sync with original name.

BR,
Han
