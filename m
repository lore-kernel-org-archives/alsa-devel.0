From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Fri, 28 Dec 2007 09:25:06 +0800
Message-ID: <1198805106.3176.5.camel@localhost.localdomain>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
	<1198697428.3732.176.camel@razman.gruemaster.com>
	<BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
	<1198716447.3732.193.camel@razman.gruemaster.com>
	<BAY109-W163C6B7386D97E65192FBBA9540@phx.gbl>
	<75b66ecd0712270942w3a2d1ab5h26647304dddae3ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DB9911037E3
	for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2007 02:24:28 +0100 (CET)
In-Reply-To: <75b66ecd0712270942w3a2d1ab5h26647304dddae3ee@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>, De Fuuss <fuuss@hotmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-12-27 at 12:42 -0500, Lee Revell wrote:
> On Dec 27, 2007 5:38 AM, De Fuuss <fuuss@hotmail.com> wrote:
> >
> > Thank you for taking interest in my problem.
> >
> > I tried alsamixer -D hw:1.0 and similar combinations, but the card doesn't speak to me:
> >
> > #alsamixer -D hw:1.0
> > alsamixer: function snd_ctl_open failed for hw:1.0: No such device
> >
> 
> Wrong syntax.  Try alsamixer -D hw:1,0
> 
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Hi, 

I googled some document about the G33 motherboard and the "Shuttle XPC
SG33G5M".

The G33 have 3 jacks on the back panel, while the "XPC SG33G5M" have 5
jacks on the back panel.

Does it mean that the XPC extend the jacks?
