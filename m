From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: PCMCIA Audigy 2 broken in 2.6.21?
Date: Tue, 03 Jul 2007 18:44:34 -0400
Message-ID: <468AD152.30703@redhat.com>
References: <4681614E.7060705@redhat.com> <46819BDD.7000107@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 29E4510388C
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 00:44:37 +0200 (CEST)
In-Reply-To: <46819BDD.7000107@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/26/2007 07:06 PM, James Courtier-Dutton wrote:
> Chuck Ebbert wrote:
>> Multiple users report the PCMCIA Audigy 2 adapter hangs the machine in
>> 2.6.21 while it work OK in 2.6.20:
>>
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=242208
>>
> 
> Which version of ALSA is this using?
> 
> cat /proc/asound/version
> Has it correctly identified the sound card?
> cat /proc/asound/cards
> 
> I don't think that anything has changed in the driver between 2.6.20 and
> 2.6.21 that would affect this. That PCMCIA card can rather easily hang
> the machine due to it's design, but removing the PCMCIA card during the
> hang should release the hang state and the PC should continue. There was
> one case where it would continue to hang, but I believe I fixed that.
> 
> Please tell me the output of the above two cat commands, and I will then
> have a better idea of what the problem is.

ALSA version 1.0.14rc3 (Wed Mar 14 07:25:50 2007 UTC)

The cards can't even be identified, so there is no /proc/asound/cards
