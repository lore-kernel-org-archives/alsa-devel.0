From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH V2 1/7] BAT: Add initial functions
Date: Tue, 13 Oct 2015 10:53:34 +0100
Message-ID: <1444730014.7124.20.camel@loki>
References: <cover.1442993440.git.han.lu@intel.com>
 <fcc0ffb3797c92fa2220e27d97e5f410d8ff8e59.1442993440.git.han.lu@intel.com>
 <s5h612ptu8o.wl-tiwai@suse.de>
 <B51200AC81AB024499A3C2C9A1BB90A83BF25DE9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A077F261B21
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 11:53:42 +0200 (CEST)
In-Reply-To: <B51200AC81AB024499A3C2C9A1BB90A83BF25DE9@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lu, Han" <han.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Gautier,
 Bernard" <bernard.gautier@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "caleb@crome.org" <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-10-12 at 08:56 +0000, Lu, Han wrote:
> Hi Takashi,
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Friday, October 2, 2015 6:56 PM
> > To: Lu, Han
> > Cc: Girdwood, Liam R; Gautier, Bernard; caleb@crome.org; alsa-devel@alsa-
> > project.org
> > Subject: Re: [PATCH V2 1/7] BAT: Add initial functions
> > 
> > On Wed, 23 Sep 2015 09:48:49 +0200,
> > han.lu@intel.com wrote:
> > >
> > > From: "Lu, Han" <han.lu@intel.com>
> > >
> > > Add main entrance, command line parsing, parameter initiating and
> > > thread initiating functions for BAT.
> > >
> > > Signed-off-by: Lu, Han <han.lu@intel.com>
> > > Signed-off-by: Liam Girdwood <liam.r.girdwood@intel.com>
> > > Signed-off-by: Bernard Gautier <bernard.gautier@intel.com>
> > >
> > > diff --git a/bat/bat.c b/bat/bat.c
> > > new file mode 100644
> > > index 0000000..54fe1ec
> > > --- /dev/null
> > > +++ b/bat/bat.c
> > > @@ -0,0 +1,603 @@
> > > +/*
> > > + * Copyright (C) 2013-2015 Intel Corporation
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > +modify
> > > + * it under the terms of the GNU General Public License as published
> > > +by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + */
> > > +
> > > +#include <unistd.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <stdbool.h>
> > > +#include <string.h>
> > > +#include <errno.h>
> > > +#include <pthread.h>
> > > +#include <getopt.h>
> > > +#include <math.h>
> > > +#include <limits.h>
> > > +
> > > +#include "aconfig.h"
> > > +#include "gettext.h"
> > > +#include "version.h"
> > > +
> > > +#include "common.h"
> > > +
> > > +#include "alsa.h"
> > > +#include "convert.h"
> > > +#include "analyze.h"
> > > +
> > > +static int get_duration(struct bat *bat) {
> > > +	float duration_f;
> > > +	long duration_i;
> > > +	char *ptrf, *ptri;
> > > +
> > > +	duration_f = strtof(bat->narg, &ptrf);
> > > +	if (duration_f == HUGE_VALF || duration_f == -HUGE_VALF) {
> > > +		fprintf(bat->err, _("duration float overflow: %f %d\n"),
> > > +				duration_f, -errno);
> > > +		return -errno;
> > > +	} else if (duration_f == 0.0 && errno != 0) {
> > > +		fprintf(bat->err, _("duration float underflow: %f %d\n"),
> > > +				duration_f, -errno);
> > > +		return -errno;
> > > +	}
> > > +
> > > +	duration_i = strtol(bat->narg, &ptri, 10);
> > > +	if (duration_i == LONG_MAX) {
> > > +		fprintf(bat->err, _("duration long overflow: %ld %d\n"),
> > > +				duration_i, -errno);
> > > +		return -errno;
> > > +	} else if (duration_i == LONG_MIN) {
> > > +		fprintf(bat->err, _("duration long underflow: %ld %d\n"),
> > > +				duration_i, -errno);
> > > +		return -errno;
> > > +	}
> > > +
> > > +	if (*ptrf == 's') {
> > > +		bat->frames = duration_f * bat->rate;
> > > +	} else if (*ptri == 0) {
> > > +		bat->frames = duration_i;
> > > +	} else {
> > > +		fprintf(bat->err, _("invalid duration: %s\n"), bat->narg);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (bat->frames <= 0 || bat->frames > MAX_FRAMES) {
> > > +		fprintf(bat->err, _("duration out of range: (0, %d(%ds))\n"),
> > > +				MAX_FRAMES, (bat->frames / bat->rate));
> > 
> > The messages strings could be unified to a single error message.
> > Otherwise you'll annoy translators, as they will need to work on each
> > different variant.
> 
> [Han] may I just change the strings to
> 	" duration overflow ..."
> 	" duration underflow ..."
> 	" duration overflow ..."
> 	" duration underflow ..."
> 	" invalid duration ..."
> 	" duration out of range ..."
> Or change the sequence and keep 2 or 3 strings like:
> 	"duration overflow/underflow ..."
> 	"invalid duration ..."
> 	"duration out of range ..."
> Since they would be clearer to developer/user?
> 

I would probably just have "duration overflow/underflow" and "invalid
duration". That cuts down 6 strings to only 2. Likewise for other
strings.

Remember to also include variables in the error output that will help
identify the error cause (since we wont be able to determine the exact
error line by string text).

> > 
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void get_sine_frequencies(struct bat *bat, char *freq) {
> > > +	char *tmp1;
> > > +
> > > +	tmp1 = strchr(freq, ',');
> > > +	if (tmp1 == NULL) {
> > > +		bat->target_freq[1] = bat->target_freq[0] = atof(optarg);
> > > +	} else {
> > > +		*tmp1 = '\0';
> > > +		bat->target_freq[0] = atof(optarg);
> > > +		bat->target_freq[1] = atof(tmp1 + 1);
> > > +	}
> > 
> > Note that parsing a floting point string is tricky.  For example, if you run it in a
> > locale that handles comma as the decimal point, this gets messy.  Did you
> > check it, e.g. with LANG=en_GB or such?
> 
> [Han] OK, I'll check the implementation.

You could even try using a : or similar (instead of commas) to
deliminate the input string. e.g. -values 1.2, 4.5 would become -values
1.2 : 4.5

Liam

> 
> > 
> > 
> > > +static void usage(struct bat *bat, char *argv[]) {
> > > +	fprintf(bat->log,
> > > +_("Usage:%s [Option]...\n"
> > > +"\n"
> > > +"-h, --help             help\n"
> > > +"-D                     sound card\n"
> > > +"-P                     playback pcm\n"
> > > +"-C                     capture pcm\n"
> > > +"-f                     sample size\n"
> > > +"-c                     number of channels\n"
> > > +"-r                     sampling rate\n"
> > > +"-n                     frames to capture\n"
> > > +"-k                     sigma k\n"
> > > +"-F                     target frequency\n"
> > > +"-p                     total number of periods to play/capture\n"
> > > +"    --log=#            path of log file. if not set, logs be put to stdout,\n"
> > > +"                       and errors be put to stderr.\n"
> > > +"    --file=#           input file\n"
> > > +"    --saveplay=#       save playback content to target file, for debug\n"
> > > +"    --local            internal loop, bypass hardware\n"
> > 
> > Why there are options with and without indentation?
> > 
> > > +), argv[0]);
> > 
> > The program name should be a const string.
> 
> [Han] OK. I followed the indentation style of aplay, to align with multiple-character options such as "--log=#". Shall I remove indentation for these options?
> 
> > 
> > 
> > Takashi
> 
> BR,
> Han Lu
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
