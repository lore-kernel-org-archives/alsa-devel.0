From: Anders Gnistrup <agn@datarespons.dk>
Subject: Re: What is wrong in this code.
Date: Wed, 19 Oct 2011 09:05:16 +0200
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5830652575@dr-mail>
References: <C516192DA6D2B74F8192CDC209D958FD5830652574@dr-mail>,
	<4E9D9736.5070801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id 1807A243A3
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 09:05:21 +0200 (CEST)
In-Reply-To: <4E9D9736.5070801@ladisch.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Tuesday, October 18, 2011 5:11 PM
To: Anders Gnistrup
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] What is wrong in this code.

Anders Gnistrup wrote:
> The code works just as expected when using the:
>     snd_ctl_elem_id_set_name(id, "PCM Playback Volume");
> But when I use the snd_ctl_elem_id_set_numid(id, numid); (with numid=23) it fails.
>       ...
>       snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
>
>       //snd_ctl_elem_id_set_numid(id, numid);
>       snd_ctl_elem_id_set_name(id, "PCM Playback Volume");

When using the numid to access elements, it must be the only field
that is set in the elem id.

Hello Clemens

I have tried just that, but is still does not work. It was my first try, but in frustration I shifted it to snd_ctl_elem_id_set_name.
If both is set (numid,name) it still works, but I think the numid is silently ignored.

There might be a known bug/'not implemented feature' in the libalsa version I got. From the amixer.c source code in alsa-utils I have found this:

	snd_ctl_elem_info_get_id(info, id);	/* FIXME: Remove it when hctl find works ok !!! */
	type = snd_ctl_elem_info_get_type(info);
	count = snd_ctl_elem_info_get_count(info);
	snd_ctl_elem_value_set_id(control, id);

In the function "cset". I assume that FIXME note function is "snd_hctl_find_elem".
The cset function also shows a valid path to get around the problem.
I have downloaded alsa-utils version 1.0.24.2.22.gaf0bf and the note is still present.

Have the problem with the /* FIXME: Remove it when hctl find works ok !!! */ been solved in latest git release of alsalib?

Regards,
Clemens
