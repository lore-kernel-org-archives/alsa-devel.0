From: Andy <hornett83@yahoo.co.uk>
Subject: Re: Intel-HDA ALC262 (again)
Date: Thu, 23 Aug 2007 20:12:18 +0100 (BST)
Message-ID: <811158.81598.qm@web27214.mail.ukl.yahoo.com>
References: <s5h8x8272ah.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web27214.mail.ukl.yahoo.com (web27214.mail.ukl.yahoo.com
	[217.146.182.104])
	by alsa0.perex.cz (Postfix) with SMTP id 1269024362
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 21:12:19 +0200 (CEST)
In-Reply-To: <s5h8x8272ah.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi, 

I can confirm that this is now working as expected. I
have a 'master' output instead of 'front', and
adjusting the levels no longer re-enables the internal
speakers.

Thanks very much!
Andy.


--- Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 23 Aug 2007 00:03:18 +0200,
> I wrote:
> > 
> > At Wed, 22 Aug 2007 20:59:36 +0100 (BST),
> > Andy wrote:
> > > 
> > > Alas, I spoke too soon. The headphone jack and
> > > internal speakers work as expected, until I
> adjust the
> > > main volume (labeled in alsamixer as 'front') at
> which
> > > point  both the internal speakers and headphones
> play!
> > > 
> > > 
> > > Unplugging the headphones and reconnecting them
> makes
> > > everything OK again.
> > > 
> > > Any ideas? (patch against 2.6.22 that makes my
> chip
> > > mostly work is attached). I guess that 
> > > alc262_hippo_automute() needs to be called
> somewhere
> > > it isn't, but I couldn't see where.
> > 
> > Ah, that's because the front (actually it should
> be master) control
> > changes the both AMP values.  It should change
> only the HP amp and
> > call alc262_hippo_automute() appropriately.
> > 
> > I'll fix this later.
> 
> ... and committed to HG tree.  Please give it a try.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
>
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 



      ___________________________________________________________
Yahoo! Answers - Got a question? Someone out there knows the answer. Try it
now.
http://uk.answers.yahoo.com/ 
