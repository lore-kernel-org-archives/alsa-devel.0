From: "Simon Dunn" <sdunn@mpc-data.co.uk>
Subject: Re: softvol plug-in dependancies?
Date: Sat, 17 May 2008 11:53:39 +0100
Message-ID: <op.ubaojrs7hpbl6d@derby>
References: <op.uaye5g1khpbl6d@derby> <s5hbq36e2gs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from molson.mpc-data.co.uk (cvs.mpc-ogw.co.uk [81.2.99.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 42D6F248F3
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 12:53:33 +0200 (CEST)
In-Reply-To: <s5hbq36e2gs.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Which ALSA version, which driver and how is your configuration setup?
> The softvol itself is known to work in most cases, but of course,
> there could be remaining bugs.  But, I suspect it's rather specific to
> your use-case...
>

Hi Takashi,

Thanks for your reply.

The version of ALSA lib and utils I'm mainly using is 1.0.10, though I've
tried version 1.0.16 and get the same results.

The Linux kernel I'm using is version 2.6.10, which includes the ALSA
driver architecture version 1.0.6.

I'm running this on a freescale mcf5475, Coldfire based platform.

I've reverted to using the dummy driver and a very basic asound.conf file,
see below, but still no joy with the plug-in.

It's the output from running amixer, once the softvol control is enabled,
that I find most curious.  Listing its contents just seems to produce an
uninitialised device.  Given the big endian nature of the cpu I'm
suspicious that this may be an endian bug, though after spending a couple
of days examining the alsa-lib code I've failed to find anything wrong up
to now, obviously ;)

Has the softvol plug-in been used on a big endian system to your knowledge?

Running amixer shows the controls implemented in the Dummy driver perfectly
well, and these can be adjusted using amixer or alsamixer.

The DMIX plug-in works just fine so if it is a bug, endian or otherwise,
then it is probably limited to the softvol plug-in rather than alsa-lib in
general.

Any help or suggestions you can provide is greatly appreciated.

Regards
Simon

.
asound.conf
.

pcm.globalvol {
     type            softvol
     slave.pcm       "hw:0,0"
     control.name    "GLOBAL Vol"
     control.card    0
}


-- 

Simon Dunn, Software Engineer
MPC Data Limited
e-mail: sdunn@mpc-data.co.uk
web: www.mpc-data.co.uk
tel: +44 (0) 1225 710600
fax: +44 (0) 1225 710601
ddi: +44 (0) 1225 710631

MPC Data Limited is a company registered in England and Wales with company  
number 05507446
Registered Address: County Gate, County Way, Trowbridge, Wiltshire, BA14  
7FJ
VAT no: 850625238

The information in this email and in the attached documents is  
confidential and may be legally privileged. Any unauthorized review,  
copying, disclosure or distribution is prohibited and may be unlawful. It  
is intended solely for the addressee. Access to this email by anyone else  
is unauthorized. If you are not the intended recipient, please contact the  
sender by reply email and destroy all copies of the original message. When  
addressed to our clients any opinions or advice contained in this email is  
subject to the terms and conditions expressed in the governing contract.
