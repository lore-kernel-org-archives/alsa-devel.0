From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: alsa-lib functions reporting conflicting
	information with two sound cards
Date: Thu, 19 Apr 2007 14:45:36 -0400
Message-ID: <75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>
	<4627B015.7030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 42706245C9
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2007 20:45:38 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id e14so1340902qbc
	for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2007 11:45:37 -0700 (PDT)
In-Reply-To: <4627B015.7030401@gmail.com>
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
To: Nicholas Smethurst <smethurst@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/19/07, Nicholas Smethurst <smethurst@gmail.com> wrote:
> Lee Revell wrote:
> > On 4/19/07, nick smethurst <nick.smethurst@gmail.com> wrote:
> >> I am rather confused that I am getting crossed information when
> >> calling snd_names_list
> >> and snd_pcm_info in order to gather information about pcm devices.
> >
> > I think ALSA's new device enumeration API can do this for you.  See
> > the implementation of aplay -l (or -L, don't remember which) in the
> > latest alsa-utils.
> Ok, thanks for the hint (no pun intended :) ).
>
> I see that the pcm_list() function has changed in aplay. The new hints
> API looks good.
>
> However, I note that snd_device_name_hint() does not return hw, plughw,
> plug, dmix, etc. Are these obtained elsewhere? I would like to build a
> complete list of all available devices in order to allow the user to
> select them from a dropdown list in a GUI.

Not sure, I don't have access to a machine with a modern ALSA now but
the new aplay list function definitely lists those.  I do know that
yours is exactly the problem it was designed to solve.

Lee
