From: "Miartus, Adam (Arion Recruitment; ADITG/ESM)" <amiartus@de.adit-jv.com>
Subject: Re: [ALSA patch] [PATCH 0/2] v2 pcm_file propagate
 write error instead	of an assert
Date: Tue, 18 Jun 2019 06:49:02 +0000
Message-ID: <B174E9FCEE9A8C46B11E4DF2E32993627A67B3@HI2EXCH01.adit-jv.com>
References: <1560322108-17074-1-git-send-email-amiartus@de.adit-jv.com>
 <s5hwohj9zhl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C38CF80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 08:49:10 +0200 (CEST)
In-Reply-To: <s5hwohj9zhl.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Dienstag, 18. Juni 2019 08:31
> To: Miartus, Adam (Arion Recruitment; ADITG/ESM) <amiartus@de.adit-
> jv.com>
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [ALSA patch] [PATCH 0/2] v2 pcm_file propagate write error
> instead of an assert
> 
> On Wed, 12 Jun 2019 08:48:26 +0200,
> Adam Miartus wrote:
> >
> > patch possible case whenre file write causes assert in pcm_file
> > plugin, by reporting error to user and printing a message
> >
> > user has a chance to recover error state, or capture
> > correct logs before assert happens, and may have an idea how
> > to recover
> >
> > Adam Miartus (2):
> >   pcm_file: do not disrupt playback on output file write fail
> >   pcm_file: report write output file error to api user
> 
> The patches have been already merged.  Any reason for resend?
> 
> 
> thanks,
> 
> Takashi

This is request v2, Im not aware I sent it two times. If so, sorry for spam.
