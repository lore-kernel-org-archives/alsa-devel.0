From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Thu, 27 Dec 2007 12:42:46 -0500
Message-ID: <75b66ecd0712270942w3a2d1ab5h26647304dddae3ee@mail.gmail.com>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
	<1198697428.3732.176.camel@razman.gruemaster.com>
	<BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
	<1198716447.3732.193.camel@razman.gruemaster.com>
	<BAY109-W163C6B7386D97E65192FBBA9540@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id AA8A5244D2
	for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2007 18:42:48 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so4666086wag.8
	for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2007 09:42:47 -0800 (PST)
In-Reply-To: <BAY109-W163C6B7386D97E65192FBBA9540@phx.gbl>
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
To: De Fuuss <fuuss@hotmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Dec 27, 2007 5:38 AM, De Fuuss <fuuss@hotmail.com> wrote:
>
> Thank you for taking interest in my problem.
>
> I tried alsamixer -D hw:1.0 and similar combinations, but the card doesn't speak to me:
>
> #alsamixer -D hw:1.0
> alsamixer: function snd_ctl_open failed for hw:1.0: No such device
>

Wrong syntax.  Try alsamixer -D hw:1,0

Lee
