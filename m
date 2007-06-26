From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: PCMCIA Audigy 2 broken in 2.6.21?
Date: Wed, 27 Jun 2007 00:06:05 +0100
Message-ID: <46819BDD.7000107@superbug.co.uk>
References: <4681614E.7060705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa0.perex.cz (Postfix) with ESMTP id E51502449E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 01:06:06 +0200 (CEST)
In-Reply-To: <4681614E.7060705@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Chuck Ebbert wrote:
> Multiple users report the PCMCIA Audigy 2 adapter hangs the machine in
> 2.6.21 while it work OK in 2.6.20:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=242208
> 

Which version of ALSA is this using?

cat /proc/asound/version
Has it correctly identified the sound card?
cat /proc/asound/cards

I don't think that anything has changed in the driver between 2.6.20 and
2.6.21 that would affect this. That PCMCIA card can rather easily hang
the machine due to it's design, but removing the PCMCIA card during the
hang should release the hang state and the PC should continue. There was
one case where it would continue to hang, but I believe I fixed that.

Please tell me the output of the above two cat commands, and I will then
have a better idea of what the problem is.

Kind Regards

James
