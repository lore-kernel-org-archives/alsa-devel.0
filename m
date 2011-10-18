From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What is wrong in this code.
Date: Tue, 18 Oct 2011 17:11:50 +0200
Message-ID: <4E9D9736.5070801@ladisch.de>
References: <C516192DA6D2B74F8192CDC209D958FD5830652574@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 5985F10385F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 17:11:30 +0200 (CEST)
In-Reply-To: <C516192DA6D2B74F8192CDC209D958FD5830652574@dr-mail>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anders Gnistrup <agn@datarespons.dk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anders Gnistrup wrote:
> The code works just as expected when using the:
>     snd_ctl_elem_id_set_name(id, "PCM Playback Volume");
> But when I use the snd_ctl_elem_id_set_numid(id, numid); (with numid=23) it fails.
>       ...
> 	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
> 
> 	//snd_ctl_elem_id_set_numid(id, numid);
> 	snd_ctl_elem_id_set_name(id, "PCM Playback Volume");

When using the numid to access elements, it must be the only field
that is set in the elem id.


Regards,
Clemens
