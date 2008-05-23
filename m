From: "Simon Dunn" <sdunn@mpc-data.co.uk>
Subject: Re: softvol plug-in dependancies? - [SOLVED]
Date: Fri, 23 May 2008 09:24:05 +0100
Message-ID: <op.ubllmfh6hpbl6d@derby>
References: <op.uaye5g1khpbl6d@derby> <s5hbq36e2gs.wl%tiwai@suse.de>
	<op.ubaojrs7hpbl6d@derby>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from molson.mpc-data.co.uk (cvs.mpc-ogw.co.uk [81.2.99.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 03E0A2460A
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 10:24:02 +0200 (CEST)
In-Reply-To: <op.ubaojrs7hpbl6d@derby>
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

Hi Takashi et al

Just thought I'd let you know that I found the bug that was causing the
softvol plug-in to fail.  As usual my suspicions were about as far from
the cause as it is possible to get; it was neither a bug in the user mode
code, nor was it an endian issue.

I found the culprit in the core module in the kernel code.  As I said in
earlier mails the kernel version I'm using (2.6.10) is not the latest and
contains the 1.0.6 version of the ALSA drivers.

The latest driver code I've looked at (1.0.15) already has fixes applied
and is not vulnerable to the same bug so I'm not reporting anything new.

I'll put a brief synopsis of the bug at the end of this email if anyone's
interested, otherwise you can stop reading now.

Takashi, thanks for your input.

Best regards
Simon







Description
-----------

I found the bug in the kernel core module in sound/core/control.c.  It
was a 2 fold issue;

1) The elem_data pointer member of the user_element struct was being
assigned an address 4 bytes into the user_element struct instead of at the
end of it.

Change the statement ..
	ue->elem_data = (char *)ue + sizeof(ue) + dimen_size;
to ..
	ue->elem_data = (char *)ue + sizeof(*ue) + dimen_size;

fixes that one.

2) The softvol control is now enumerated correctly but still does not work;
amixer and alsamixer both report the volume as zero and neither can modify
it.  The reason for this is that the user_element struct is not holding
information pertaining to the min and max volumes levels permitted by the
control.  This information is passed into the driver via the _info
parameter of snd_ctl_elem_add but was not being retained.

To fix it is a simple matter of retaining all the information provided by
snd_ctl_elem_add and returning it appropriately.

As I said both of these issues are accounted for in latter versions of the
driver code so this description of them is for information only, should  
someone
else trip over the same bug when using older versions of the architecture.

~Simon



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
