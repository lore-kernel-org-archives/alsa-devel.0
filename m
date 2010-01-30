From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [Q] playing / recording mono on a stereo-only
	hardware
Date: Sat, 30 Jan 2010 17:29:05 +0100
Message-ID: <4B645E51.900@gandalf.sssup.it>
References: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 603F224337
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 17:29:13 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guennadi Liakhovetski wrote:
> Hi
>
> I know this question belongs rather to alsa-users, and I did ask it there, 
> but got no solution so far. Maybe someone here can help.
>
> The recently posted SuperH SIU driver only supports stereo playback and 
> capture (channels_min = channels_max = 2). Is there a way to tell alsa-lib 
> to duplicate the mono-channel during playback and to mix recorded channels 
> (or use one of them), if mono recording is requested?
>   
I'm not an expert but I think that you can use plughw support of alsa-lib

pcm.record {
       type plug
       slave {
               pcm record_hw
       }
       route_policy average
       rate_converter "linear"
}

I think that automatically change rate and channel for supporting mono 
channel too

Michael


> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
