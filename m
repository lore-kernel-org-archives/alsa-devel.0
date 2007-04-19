From: Nicholas Smethurst <smethurst@gmail.com>
Subject: Re: alsa-lib functions reporting conflicting
 information with two sound cards
Date: Thu, 19 Apr 2007 20:08:21 +0200
Message-ID: <4627B015.7030401@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E026245B4
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2007 20:08:26 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so579068ugf
	for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2007 11:08:25 -0700 (PDT)
In-Reply-To: <75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>
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

Lee Revell wrote:
> On 4/19/07, nick smethurst <nick.smethurst@gmail.com> wrote:
>> I am rather confused that I am getting crossed information when
>> calling snd_names_list
>> and snd_pcm_info in order to gather information about pcm devices.
>
> I think ALSA's new device enumeration API can do this for you.  See
> the implementation of aplay -l (or -L, don't remember which) in the
> latest alsa-utils.
Ok, thanks for the hint (no pun intended :) ).

I see that the pcm_list() function has changed in aplay. The new hints 
API looks good.

However, I note that snd_device_name_hint() does not return hw, plughw, 
plug, dmix, etc. Are these obtained elsewhere? I would like to build a 
complete list of all available devices in order to allow the user to 
select them from a dropdown list in a GUI.

Nicholas
