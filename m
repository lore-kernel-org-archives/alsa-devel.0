From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: print audio ring buffer in kernel space
Date: Thu, 29 Oct 2015 21:06:26 +0100
Message-ID: <56327C42.6000202@ladisch.de>
References: <CACaQK7C7bH1wHomQyJLS=N1V+m5DeSus=4cjB=2WMv4B+3Np+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 27BC52651A5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 21:07:02 +0100 (CET)
In-Reply-To: <CACaQK7C7bH1wHomQyJLS=N1V+m5DeSus=4cjB=2WMv4B+3Np+Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ankhit Vivekananda wrote:
> I am trying to print the ring buffer used for DMA transfer using ALSA in
> kernel space. I was able to print the ring buffer in user space after
> calling the snd_pcm_readi() function. But, wanted to know as to which file
> I need to be looking at to print the hardware buffer in kernel space.

The driver typically does not access the buffer.  There is no such file.

(And why would you need it?  Do you suspect an error in the
implementation of snd_pcm_readi()?)


Regards,
Clemens
