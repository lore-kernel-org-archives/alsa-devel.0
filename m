From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What's the deal with elements?
Date: Thu, 24 Nov 2011 14:37:56 +0100
Message-ID: <4ECE48B4.8010607@ladisch.de>
References: <CAAs5ODuE2MPa9WULW-rWSwcBxdPTJk35fUqPYsvMBzCv=QjK-g@mail.gmail.com>
	<4ECCA8C9.7050400@ladisch.de>
	<CAAs5ODsL2P41Zi7nWcjG8=1zd9j2yjJvuDtsDD6xR-2pY_03QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 3035310399E
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 14:37:01 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 890C02154F
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:36:57 -0500 (EST)
In-Reply-To: <CAAs5ODsL2P41Zi7nWcjG8=1zd9j2yjJvuDtsDD6xR-2pY_03QA@mail.gmail.com>
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
> the "enum _snd_ctl_elem_iface" definition hints at these element lists
> containing PCM devices.

iface=PCM means that the control is associated with some PCM device
(identified by device/subdevice).

> Lastly, my calls to snd_ctl_elem_list_get_index() always return 0.
> Shouldn't they be returning the index passed in?

A control is identified either by the numid, a non-zero unique number,
or by the interface/device/subdevice/name/index fields.  The index field
is used when there are multiple controls that would otherwise have the
same ID.


Regards,
Clemens
