From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] ad1848_lib: replace common delay loop by
 function
Date: Wed, 5 Sep 2007 18:42:25 +0200
Message-ID: <20070905184225.5eaa6655.krzysztof.h1@wp.pl>
References: <20070904235332.ca7a3c56.krzysztof.h1@wp.pl>
	<46DDDF15.8040606@gmail.com> <s5h7in58dtu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 58C0F10383B
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 18:36:01 +0200 (CEST)
In-Reply-To: <s5h7in58dtu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 05 Sep 2007 15:02:53 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 05 Sep 2007 00:41:25 +0200,
> Rene Herman wrote:
> > 
> > On 09/04/2007 11:53 PM, Krzysztof Helt wrote:
> > 
> > > +static void snd_ad1848_ready(struct snd_ad1848 *chip)
> > 
> > Same request for a name change -- "ready" sounds boolean to me...
> 
> Agreed.  Also, the error output of timeout can be better in
> snd_ad1848_ready().
> 

As to the error output. The moved error output want be able to
display register and value to write (unless it will have parameters only for this).
Also there is no error message in the snd_ad1848_dout().

I'll leave messages as they are. I'll change the name of the function to snd_ad1848_wait.

Regards,
Krzysztof
