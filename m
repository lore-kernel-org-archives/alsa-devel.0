From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH - UCM 1/2] control: enable octal and
	hexadecimal parse
Date: Wed, 14 Jan 2015 01:28:00 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A833E6C0@SHSMSX101.ccr.corp.intel.com>
References: <1421118039-8075-1-git-send-email-han.lu@intel.com>
 <s5ha91mipvp.wl-tiwai@suse.de> <s5htwzu1mce.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 702B1260578
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 02:28:07 +0100 (CET)
In-Reply-To: <s5htwzu1mce.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, January 14, 2015 4:02 AM
> To: Takashi Iwai
> Cc: Lu, Han; Liam Girdwood; alsa-devel@alsa-project.org
> Subject: Re: [PATCH - UCM 1/2] control: enable octal and hexadecimal parse
> 
> At Tue, 13 Jan 2015 17:53:14 +0100,
> Takashi Iwai wrote:
> >
> > At Tue, 13 Jan 2015 11:00:38 +0800,
> > han.lu@intel.com wrote:
> > >
> > > From: "Lu, Han" <han.lu@intel.com>
> > >
> > > Signed-off-by: Lu, Han <han.lu@intel.com>
> >
> > Looks good to me.  Liam, any objection for this extension?
> 
> Erm, sorry, I correct my statement: this is buggy.  Look at the code:
> 
> > > -	val = strtol(s, &p, 10);
> > > +	val = strtol(s, &p, 0);
> > >  	if (*p == '.') {
> > >  		p++;
> > > -		strtol(p, &p, 10);
> > > +		strtol(p, &p, 0);
> 
> The second strtol() is for skipping the decimals.  So this has to be 10-based.
> That is, use zero-base only for the first strtol().
> 
Yes. I thought of skipping hexadecimal, but string begin with ".0x" looks not reasonable, and string begin with ".0" will not be skipped as expected with this patch.
I have removed the second change and resend the patch. Please review, Thanks.

BR,
Han Lu
> 
> Takashi
