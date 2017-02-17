From: "amidi@LEFerguson.com" <amidi@LEFerguson.com>
Subject: Re: Help with midi player application
Date: Fri, 17 Feb 2017 14:49:55 +0000
Message-ID: <BN6PR05MB3009240F07BF616C635EA8ABD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
References: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
 <4c95ab4d-55a8-bbc7-f758-7022ab800440@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0125.outbound.protection.outlook.com [104.47.42.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 16AE92671B4
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 15:49:58 +0100 (CET)
In-Reply-To: <4c95ab4d-55a8-bbc7-f758-7022ab800440@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I took the technique from what pmidi did, which seemed like the most on-topic example.  It also seemed a bit easier to change tempo.

I agree it sounds like they are wrong, except (a) I do not think they actually are (debug output as I queued them) and (b) when I increase the output size of the queue, the pauses happen at different times, even though the enqueued data is otherwise identical.

But that said I don't think it is hard to do the running calculations and change it, if you think there's merit?

Related question: Is there any way to query the queue for what is in it?   Not just how many?   See if somehow they ticks in the queue indeed are later than the current queue tick? 

Linwood

PS. Thanks for the quick reply!

-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Friday, February 17, 2017 9:19 AM
To: amidi@LEFerguson.com; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Help with midi player application

amidi@LEFerguson.com wrote:
> The symptoms are on a fast, long piece play hangs for a long period of 
> time (many seconds).  I put into the loop queries as to queue info/ 
> state/etc, and what I see is the queue tick advancing correctly during 
> this pause, but the events in the queue are steady at about 80%full 
> and not emptying.

This sounds as if the events have the wrong time stamp.

> snd_seq_ev_schedule_tick called with parameter 2 = 1 for relative ticks.

Why relative?  (I'm not aware of anybody ever using this flags; it's possible that there is some bug ...)


Regards,
Clemens
