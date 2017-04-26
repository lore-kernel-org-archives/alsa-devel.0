From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA / Soundcard latency
Date: Wed, 26 Apr 2017 12:47:52 +0200
Message-ID: <f279577c-548b-0141-17a9-e09e5a839634@ladisch.de>
References: <DBXPR06MB286900FD1B5EEF225F3A3B1C71E0@DBXPR06MB286.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DA16E2670B0
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 12:47:56 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 933D45580F5B
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 12:47:55 +0200 (CEST)
In-Reply-To: <DBXPR06MB286900FD1B5EEF225F3A3B1C71E0@DBXPR06MB286.eurprd06.prod.outlook.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Feilmeier Daniel (Ask De) wrote:
> We have very strong requirements regarding the maximum latency from
> audio input via line in to audio output. We would like to achieve a
> maximum latency < 1ms. The alsaloop example mentions a latency of 1 ms
> which is on our test setup

What hardware?  USB and FireWire have long packet queues.

> We tried different soundcards and found out that they have an
> internal FIFO, which seems to be one of the limiting factors.

What are the numbers?

What settings did you use for alsaloop?


Regards,
Clemens
