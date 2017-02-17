From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help with midi player application
Date: Fri, 17 Feb 2017 15:18:49 +0100
Message-ID: <4c95ab4d-55a8-bbc7-f758-7022ab800440@ladisch.de>
References: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF472671B4
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 15:18:51 +0100 (CET)
In-Reply-To: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "amidi@LEFerguson.com" <amidi@LEFerguson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

amidi@LEFerguson.com wrote:
> The symptoms are on a fast, long piece play hangs for a long period of
> time (many seconds).  I put into the loop queries as to queue info/
> state/etc, and what I see is the queue tick advancing correctly during
> this pause, but the events in the queue are steady at about 80%full
> and not emptying.

This sounds as if the events have the wrong time stamp.

> snd_seq_ev_schedule_tick called with parameter 2 = 1 for relative ticks.

Why relative?  (I'm not aware of anybody ever using this flags; it's
possible that there is some bug ...)


Regards,
Clemens
