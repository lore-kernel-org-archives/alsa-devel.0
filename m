From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: How to unload a sound module.
Date: Wed, 27 Jan 2010 21:43:41 +1300
Message-ID: <4B5FFCBD.7010107@audioscience.com>
References: <e5baf3861001261137x2b186559ma8dd1756b9a23455@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2723910384D
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 09:44:10 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Na3VM-0005CA-Pc
	for alsa-devel@alsa-project.org; Wed, 27 Jan 2010 09:44:04 +0100
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 09:44:04 +0100
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 09:44:04 +0100
In-Reply-To: <e5baf3861001261137x2b186559ma8dd1756b9a23455@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yiliang Bao wrote:
> Hi,
> 
> I am new to alsa driver development. The first problem I encountered is I
> could not unload a module just inserted. I always get the following message
> (using snd-dummy as an example).
> 
>> sudo rmmod snd-dummy
> ERROR: Module snd_dummy is in use
> 
> I checked who is using snd-dummy. Here is what I got and I do not know what
> applications are using it.

sudo lsof /dev/snd/*
