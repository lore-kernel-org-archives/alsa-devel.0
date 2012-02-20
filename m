From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Direct use of the DMA buffer?
Date: Mon, 20 Feb 2012 10:22:29 +0100
Message-ID: <4F4210D5.5070709@perex.cz>
References: <4F4210A6.8010902@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A0A7246E9
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:21:33 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	0E0AB1498C9
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:21:33 +0100 (CET)
Received: from t510.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	30C5E850AC
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:21:32 +0100 (CET)
In-Reply-To: <4F4210A6.8010902@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 20.2.2012 09:38, Pavel Hofman wrote:
> 
> Dne 20.2.2012 09:11, Clemens Ladisch napsal(a):
>> Pavel Hofman wrote:
>>> Please excuse my ignorance, but is it possible for an application to
>>> directly use/output to the DMA buffer allocated by the kernel in
>>> hw_params?
>>
>> Set one of the SND_PCM_ACCESS_MMAP_* access types and then use
>> snd_pcm_mmap_begin/commit.
>>
> 
> Clemens, thanks a lot for the information. How does it work when the
> alsa-lib chain contains plugins, such as plug, rate, etc.? I would
> assume the application circumvents these.

Nope. The mmap commit mechanism was introduced to keep the plugin
interface functional. The direct mmap access to the DMA buffer is only
applied for the direct hw: devices. If a plugin is used inside alsa-lib,
the application talks to the plugin chain (it means that an intermediate
buffer for samples can be allocated to let things working).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
