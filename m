From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 09/10] alsabat: use variable for thread
 return	value
Date: Mon, 14 Mar 2016 09:15:20 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D3AAC58@SHSMSX101.ccr.corp.intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
 <3788d26a68d34132a918b0eb19f7f0a7eb552641.1456907242.git.han.lu@intel.com>
 <s5hegbhyw88.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 55ED42605CA
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 10:17:22 +0100 (CET)
In-Reply-To: <s5hegbhyw88.wl-tiwai@suse.de>
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Gautier, Bernard" <bernard.gautier@intel.com>, "Popescu,
 Edward C" <edward.c.popescu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, March 11, 2016 9:34 PM
> To: Lu, Han <han.lu@intel.com>
> Cc: liam.r.girdwood@linux.intel.com; Gautier, Bernard
> <bernard.gautier@intel.com>; Popescu, Edward C
> <edward.c.popescu@intel.com>; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 09/10] alsabat: use variable for thread
> return value
> 
> On Wed, 02 Mar 2016 09:53:19 +0100,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Replace fixed "1" to variable for thread return value.
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> >
> > diff --git a/bat/alsa.c b/bat/alsa.c
> > index 0a5f899..189b0e9 100644
> > --- a/bat/alsa.c
> > +++ b/bat/alsa.c
> > @@ -309,13 +309,13 @@ void *playback_alsa(struct bat *bat)
> >  	if (err != 0) {
> >  		fprintf(bat->err, _("Cannot open PCM playback device: "));
> >  		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
> > -		retval_play = 1;
> > +		retval_play = err;
> >  		goto exit1;
> >  	}
> >
> >  	err = set_snd_pcm_params(bat, &sndpcm);
> >  	if (err != 0) {
> > -		retval_play = 1;
> > +		retval_play = err;
> >  		goto exit2;
> >  	}
> >
> > @@ -332,13 +332,13 @@ void *playback_alsa(struct bat *bat)
> >  			fprintf(bat->err, _("Cannot open file for playback: "));
> >  			fprintf(bat->err, _("%s %d\n"),
> >  					bat->playback.file, -errno);
> > -			retval_play = 1;
> > +			retval_play = -errno;
> 
> Is the original errno still preserved at this point...?

[han] I think so, the complete code section here is
	...
	bat->fp = fopen(bat->playback.file, "rb");
	if (bat->fp == NULL) {
		fprintf(bat->err, _("Cannot open file for playback: "));
		fprintf(bat->err, _("%s %d\n"),
				bat->playback.file, -errno);
-		retval_play = 1;
+		retval_play = -errno;
		goto exit3;
	}
	...
So the use of errno should be safe.

BR,
Han

> 
> 
> Takashi
