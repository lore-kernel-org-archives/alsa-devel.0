From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: 1.0.15: volume levels drift on HDA with STAC92XX
	codec
Date: Thu, 1 Nov 2007 20:17:30 +0200
Message-ID: <200711012017.30376.maximlevitsky@gmail.com>
References: <472A113B.7030406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B9182436E
	for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2007 19:17:52 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so543638ugf
	for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2007 11:17:51 -0700 (PDT)
In-Reply-To: <472A113B.7030406@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Chuck Ebbert <cebbert@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 01 November 2007 19:47:39 Chuck Ebbert wrote:
> We have two reports now of unstable volume levels:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=361051
> https://bugzilla.redhat.com/show_bug.cgi?id=354981
> 
> This is with kernel 2.6.23 plus the two ALSA merge patches from
> 2.6.23-rc1.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
Probably this isn't a software bug.
Probably this chip country to datasheet doesn't have usable "Master Volume" (volume knob) control.


The master volume control wasn't present before, I added support for it, using data-sheets.
I need to know what exactly sigmatel codec was used in both cases.


Best regards,
	Maxim Levitsky
