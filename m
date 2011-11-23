From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What's the deal with elements?
Date: Wed, 23 Nov 2011 09:03:21 +0100
Message-ID: <4ECCA8C9.7050400@ladisch.de>
References: <CAAs5ODuE2MPa9WULW-rWSwcBxdPTJk35fUqPYsvMBzCv=QjK-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 024D810381C
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 09:03:26 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7034420509
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 03:03:23 -0500 (EST)
In-Reply-To: <CAAs5ODuE2MPa9WULW-rWSwcBxdPTJk35fUqPYsvMBzCv=QjK-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Borg Onion <borg.onion@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Borg Onion wrote:
> Element used = 0, count = 7
> 
> Whenever I try to access the elements by their index though, I get errors.

It's hard to find out what you're talking about without the code, but
this looks as if you've called snd_ctl_elem_list_get_used/count() and
are now wondering why the other snd_ctl_elem_list_get_* functions don't
work.

> What's the meaning of "used" vs. "count"?

The count is the number of elements that the card has.
"used" is the number of elements that you have in the list.

To actually get element IDs, you have to allocate space for them with
snd_ctl_elem_list_alloc_space() (and then don't forget to call
snd_ctl_elem_list_free_space() afterwards), and call snd_ctl_elem_list()
again.  (All this is quite undocumented.)

> What are these elements used for?

Mixer controls.

> How does one do device discovery?

snd_device_name_hint(), or functions like snd_ctl_pcm_next_device().


Regards,
Clemens
