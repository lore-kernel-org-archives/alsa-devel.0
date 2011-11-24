From: Borg Onion <borg.onion@gmail.com>
Subject: Re: What's the deal with elements?
Date: Wed, 23 Nov 2011 21:52:55 -0800
Message-ID: <CAAs5ODsL2P41Zi7nWcjG8=1zd9j2yjJvuDtsDD6xR-2pY_03QA@mail.gmail.com>
References: <CAAs5ODuE2MPa9WULW-rWSwcBxdPTJk35fUqPYsvMBzCv=QjK-g@mail.gmail.com>
	<4ECCA8C9.7050400@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 068352447D
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 06:52:58 +0100 (CET)
Received: by ywp27 with SMTP id 27so2293701ywp.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 21:52:56 -0800 (PST)
In-Reply-To: <4ECCA8C9.7050400@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> > What's the meaning of "used" vs. "count"?
>

> The count is the number of elements that the card has.
> "used" is the number of elements that you have in the list.
>
> To actually get element IDs, you have to allocate space for them with
> snd_ctl_elem_list_alloc_space() (and then don't forget to call
> snd_ctl_elem_list_free_space() afterwards), and call snd_ctl_elem_list()
> again.  (All this is quite undocumented.)
>
>
Wow, I NEVER would have guessed that, and I can truly find no documentation
on the call semantics here, hence my basic questions to this mailing list.

The good news is, your guidance did produce the right results.  But it
sucks you have to probe for devices with *_next_device()...you'd think ALSA
would give you a nice table of devices that are present on the card.  I was
hoping the element list would be that.  Even the "enum _snd_ctl_elem_iface"
definition hints at these element lists containing PCM devices.  Am I
missing something here?

Lastly, my calls to snd_ctl_elem_list_get_index() always return 0.
 Shouldn't they be returning the index passed in?  (I don't really get the
purpose of this function)

The source code for what I've got so far is here:
http://pastebin.com/1pW1MK4f

--BO
