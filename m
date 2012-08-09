From: Kaskinen Tanu <tanu.kaskinen@digia.com>
Subject: Re: [PATCH] ucm: Allow cset commands to have values
	with spaces.
Date: Thu, 9 Aug 2012 17:44:12 +0300
Message-ID: <1344523452.4283.43.camel@IT-D-4QB9Z4J>
References: <1344519811-29520-1-git-send-email-tanu.kaskinen@digia.com>
 <s5hr4rg17m0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id B223D2663A4
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 16:14:27 +0200 (CEST)
In-Reply-To: <s5hr4rg17m0.wl%tiwai@suse.de>
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

On Thu, 2012-08-09 at 16:07 +0200, Takashi Iwai wrote:
> At Thu, 9 Aug 2012 16:43:31 +0300,
> Tanu Kaskinen wrote:
> > @@ -170,8 +170,23 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
> >  	snd_ctl_elem_value_malloc(&value);
> >  	snd_ctl_elem_info_malloc(&info);
> >  
> > -	pos = strrchr(cset, ' ');
> > -	if (pos == NULL) {
> > +	/* Find the space after the element id, taking quoting with
> > +	   single-quotes into account. */
> > +	for (pos = cset; *pos != '\0'; pos += strcspn(pos, "' ")) {
> > +		if (*pos == ' ')
> > +			break;
> > +		if (*pos == '\'') {
> 
> A double-quote can be supported easily here...

True, I'll post v2 soon.

-- 
Tanu
