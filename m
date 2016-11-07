From: David Jordan <david2@system76.com>
Subject: Re: Fixup set PCM/headphones volume from Master
Date: Mon, 07 Nov 2016 13:36:21 -0800
Message-ID: <1478554581.3026158.780400457.4CB1BFD6@webmail.messagingengine.com>
References: <1478537979.2123627.780087305.7503B79D@webmail.messagingengine.com>
 <63dfc720-71c9-9556-61cc-9fec629ddef5@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 2D9F3266552
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 22:36:21 +0100 (CET)
In-Reply-To: <63dfc720-71c9-9556-61cc-9fec629ddef5@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's HDA, Realtek ALC898.  The headphones jack (analog 3.5mm output)
(0x1b) is connected to a separate ESS DAC, which takes sound input from
the PCM SPDIF output.  

-- 
  David Jordan
  david2@system76.com

On Mon, Nov 7, 2016, at 01:19 PM, Clemens Ladisch wrote:
> David Jordan wrote:
> > I'm working on a kernel-level fixup for a set of hardware
> 
> What hardware?  If HDA, which codec, and how is it connected?
> 
> 
> Regards,
> Clemens
