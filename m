From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Decibel range / value from  snd_hctl_elem_t
Date: Fri, 29 Apr 2011 11:04:45 +0200
Message-ID: <4DBA7F2D.2000206@gmx.de>
References: <4DB9B629.8090700@gmx.de> <4DBA5795.10902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id D8F61244BF
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 11:04:51 +0200 (CEST)
In-Reply-To: <4DBA5795.10902@ladisch.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 29.04.2011 08:15, schrieb Clemens Ladisch:
> Sebastian H. wrote:
>> I'm stuck with the hctl interface.
>> What is the best way to get
>> 1. the decibel range from a snd_hctl_elem_t
>> 2. the decibel value from a snd_hctl_elem_t
> 
> The hctl stuff is just a thin wrapper over the ctl stuff, so call
> snd_hctl_ctl and snd_hctl_elem_get_id, then snd_ctl_*dB*.

Ok, that works.
Thank you Clemens.
