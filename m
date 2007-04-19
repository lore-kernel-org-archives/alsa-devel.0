From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: alsa-lib functions reporting conflicting
	information with two sound cards
Date: Thu, 19 Apr 2007 11:46:53 -0400
Message-ID: <75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F5D6245AD
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2007 17:46:55 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so471733nzf
	for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2007 08:46:53 -0700 (PDT)
In-Reply-To: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
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
To: nick smethurst <nick.smethurst@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/19/07, nick smethurst <nick.smethurst@gmail.com> wrote:
> Hey guys
>
> I am rather confused that I am getting crossed information when
> calling snd_names_list
> and snd_pcm_info in order to gather information about pcm devices.
>
> I have two sound cards in my development pc: RME Digi 96/8 PCI and an
> onboard VIA 8237.
>
> I'm trying to develop a piece of code that generates a list of objects
> containing pcm device information, including information on virtual
> devices.

I think ALSA's new device enumeration API can do this for you.  See
the implementation of aplay -l (or -L, don't remember which) in the
latest alsa-utils.

Lee
