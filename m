From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Using dmix/dsnoop/dshare to access individual
	channels
Date: Fri, 21 Dec 2007 01:53:09 -0500
Message-ID: <75b66ecd0712202253r3bbabaaek9d44bfeced32aad9@mail.gmail.com>
References: <0MKp8S-1J2adg1age-0007la@mrelay.perfora.net>
	<s5hfxy0xi5h.wl%tiwai@suse.de>
	<0MKp8S-1J56n908qn-0006u1@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id CB37A243BF
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 07:53:10 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so133854rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 22:53:09 -0800 (PST)
In-Reply-To: <0MKp8S-1J56n908qn-0006u1@mrelay.perfora.net>
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
To: Steve Strobel <steve.strobel@link-comm.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 19, 2007 4:49 PM, Steve Strobel <steve.strobel@link-comm.com> wrote:
> Thanks for the reply.  I think I understand at least the basics of
> how Jack works, and I can see how it would work well in
> general.  Unfortunately, I am working on an embedded Blackfin system
> running uClinux and I don't find any evidence that Jack has been
> ported to that platform.  Also, all of the (simple command-line)
> utilities that I hoped to use like aplay/record, mp3play, etc. are
> set up for ALSA;  I suppose there might be Jack equivalents or a way
> of using an adapter of some sort.  That sounds rather involved, and
> defeats at least some of the advantages of native Jack apps.
>
> Would it be a reasonable design to make small executables to do jobs
> similar to dmix/dsnoop/dshare that do their I/O on named pipes
> (fifos), then run aplay/arecord... on those pipes?

Once you do this you'll have re-implemented 90% of JACK.

JACK should work on your platform - it uses the same POSIX APIs
(shared memory and FIFOs) as ALSA to mix and route audio.  Actually
dmix/dsnoop/dshare have more requirements (SysV IPC).  You should at
least try it.

There are JACKified equivalents to all the apps you mention.  aplay
and arecord aren't designed for everyday use anyway; they're really
just for demonstrating ALSA features and testing drivers.

An added bonus is that you'll be using a system that's already been
proven in the field, with VERY demanding professional audio apps, on
everything from embedded systems to top of the line workstations.

Trust me, I've done Linux audio development for embedded systems, and
once you go JACK you'll never go back ;-)

Lee
