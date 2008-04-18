From: "Simon Dunn" <sdunn@mpc-data.co.uk>
Subject: Alsa Driver on Coldfire
Date: Fri, 18 Apr 2008 11:02:56 +0100
Message-ID: <op.t9swu605hpbl6d@derby>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from molson.mpc-data.co.uk (cvs.mpc-ogw.co.uk [81.2.99.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DFCD24813
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 12:02:49 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi

I've been given the job of writing a sound card driver using the alsa  
architecture for a
development platform that uses a coldfire chip.

The first thing I came across was a chunky 'if !M68K' in sound/Kconfig,  
which excludes all
the alsa components.  I can't find any reason for this in the mailing list  
archives or
on the web in general, so I'm wondering if anybody knows why the M68K  
architecture is
excluded?

Cheers
Simon

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
