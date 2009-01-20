From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] Remove definition for surround sound
 devices on ICE1712.
Date: Tue, 20 Jan 2009 14:38:45 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901201434500.8466@tm8103.perex-int.cz>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<1232455075-27712-2-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201339310.8466@tm8103.perex-int.cz>
	<m2ocy29lyw.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EBFF01037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 14:38:45 +0100 (CET)
In-Reply-To: <m2ocy29lyw.fsf@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=" <flameeyes@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2009, Diego E. 'Flameeyes' Petten? wrote:

> Jaroslav Kysela <perex@perex.cz> writes:
> 
> > ICE1712 has 8 independent outputs, so why surround definitions do not 
> > make sense?
> 
> Because ICE1712-based cards have, physically, two RCA and one S/PDIF
> jacks for input, and the same amount for output.

Do you have seen M-Audio Delta 1010 ? The problem is that we have hardware 
that can be used for surround output, but alsa-lib configuration files 
cannot describe the restrictions in detail now.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
