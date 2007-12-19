From: Steve Strobel <steve.strobel@link-comm.com>
Subject: Re: Using dmix/dsnoop/dshare to access individual
 channels
Date: Wed, 19 Dec 2007 14:49:22 -0700
Message-ID: <0MKp8S-1J56n908qn-0006u1@mrelay.perfora.net>
References: <0MKp8S-1J2adg1age-0007la@mrelay.perfora.net>
	<s5hfxy0xi5h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by alsa0.perex.cz (Postfix) with ESMTP id BEE642467F
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 22:49:34 +0100 (CET)
In-Reply-To: <s5hfxy0xi5h.wl%tiwai@suse.de>
References: <0MKp8S-1J2adg1age-0007la@mrelay.perfora.net>
	<s5hfxy0xi5h.wl%tiwai@suse.de>
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


>Steve Strobel wrote:
> > I am using a 4-input, 8-output codec (AD1938) in an application 
> similar to a live sound mixing
>  ...snip...
> > Am I on the right track, or would I be better off adding 
> functionality to the crosspoint application
> > to read and write wave files?  Thanks for any suggestions.

Takashi Iwai <tiwai@suse.de> wrote:
>Unfortunately this won't work.  d* plugins can have only hw type slave
>PCM.  So, dshare cannot have dsnoop as its slave.
>
>I recommend you to use simply JACK for such a purpose.  It's exactly
>designed for this kind of work.

Thanks for the reply.  I think I understand at least the basics of 
how Jack works, and I can see how it would work well in 
general.  Unfortunately, I am working on an embedded Blackfin system 
running uClinux and I don't find any evidence that Jack has been 
ported to that platform.  Also, all of the (simple command-line) 
utilities that I hoped to use like aplay/record, mp3play, etc. are 
set up for ALSA;  I suppose there might be Jack equivalents or a way 
of using an adapter of some sort.  That sounds rather involved, and 
defeats at least some of the advantages of native Jack apps.

Would it be a reasonable design to make small executables to do jobs 
similar to dmix/dsnoop/dshare that do their I/O on named pipes 
(fifos), then run aplay/arecord... on those pipes?

Steve


---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com
