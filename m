From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Kirkwood SoC - AVB support questions ..?
Date: Sat, 10 Jul 2010 20:15:51 +1200
Message-ID: <4C382C37.7090904@audioscience.com>
References: <20100709200117.GC7635@00110101.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BA392457E
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 10:16:48 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L5C003VP1MGXH20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 10 Jul 2010 20:15:52 +1200 (NZST)
In-reply-to: <20100709200117.GC7635@00110101.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: errordeveloper@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/07/10 08:01, errordeveloper@gmail.com wrote:

> How are the CobraNet and EtherSound drivers designed, has anyone used
> those cards ?? (one was from DigiGram and another from Audio Science IIRC)

AudioScience ASI6416 and AS6316 cards use cobranet processor from
Cirrus, and appear to the host as a standard soundcard.

Similarly, ASI6585 uses hardware implementation of Axia livewire protocol.

So, none of the network audio protocol is handled by the host PC.


-- 
Eliot Blennerhassett
AudioScience Inc.
