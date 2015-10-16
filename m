From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH V3 3/4] BAT: Adjust parameters and strings
Date: Fri, 16 Oct 2015 08:57:18 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83BF27201@SHSMSX101.ccr.corp.intel.com>
References: <cover.1444982584.git.han.lu@intel.com>
 <3a99986b04bfd6a0e845d91c9a22e1d3b85e6653.1444982584.git.han.lu@intel.com>
 <s5hio67jj88.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AC4D226062F
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 10:57:21 +0200 (CEST)
In-Reply-To: <s5hio67jj88.wl-tiwai@suse.de>
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
Cc: "Gautier, Bernard" <bernard.gautier@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, October 16, 2015 4:44 PM
> To: Lu, Han
> Cc: Girdwood, Liam R; Gautier, Bernard; alsa-devel@alsa-project.org
> Subject: Re: [PATCH V3 3/4] BAT: Adjust parameters and strings
> 
> On Fri, 16 Oct 2015 10:12:05 +0200,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Use rational parameters and clearer comments.
> 
> This doesn't match with what you actually changed exactly.
> 
> In general, please give more care and love to the changelog comments.
> This is the only verbose information the later reader can receive.
> 
> Also, using argv[0] as the command name isn't appropriate.  You can pass a
> different name to argv[0] freely.  Use a constant pre-defined program name
> instead.

Sorry! I'll be more careful about change log comments. And I'll use pre-defined
name instead of argv[0].

BR,
Han Lu
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> >
> > diff --git a/bat/bat.c b/bat/bat.c
> > index 2320984..02b1abd 100644
> > --- a/bat/bat.c
> > +++ b/bat/bat.c
> > @@ -268,16 +268,16 @@ static void test_capture(struct bat *bat)
> >  	}
> >  }
> >
> > -static void usage(struct bat *bat, char *argv[])
> > +static void usage(struct bat *bat, const char *command)
> >  {
> >  	fprintf(bat->log,
> >  _("Usage:%s [Option]...\n"
> >  "\n"
> >  "-h, --help             help\n"
> > -"-D                     sound card\n"
> > +"-D                     pcm for both playback and capture\n"
> >  "-P                     playback pcm\n"
> >  "-C                     capture pcm\n"
> > -"-f                     sample size\n"
> > +"-f                     sample format\n"
> >  "-c                     number of channels\n"
> >  "-r                     sampling rate\n"
> >  "-n                     frames to capture\n"
> > @@ -289,7 +289,7 @@ _("Usage:%s [Option]...\n"
> >  "    --file=#           input file\n"
> >  "    --saveplay=#       save playback content to target file, for debug\n"
> >  "    --local            internal loop, bypass hardware\n"
> > -), argv[0]);
> > +), command);
> >  	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
> >  			snd_pcm_format_name(SND_PCM_FORMAT_U8),
> >
> 	snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
> > @@ -402,7 +402,7 @@ static void parse_arguments(struct bat *bat, int argc,
> char *argv[])
> >  			break;
> >  		case 'h':
> >  		default:
> > -			usage(bat, argv);
> > +			usage(bat, argv[0]);
> >  			exit(EXIT_SUCCESS);
> >  		}
> >  	}
> > --
> > 1.9.1
> >
