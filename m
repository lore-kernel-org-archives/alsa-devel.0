From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM substream
Date: Thu, 09 Aug 2012 14:49:07 +0200
Message-ID: <5023B1C3.40001@ladisch.de>
References: <CABnBtVCEP0z_2_1NaPyvMpq1C=6CM9fPcM=6znpjGMZaT8STNQ@mail.gmail.com>
 <CABnBtVDJQ_0nTLwfFrbMN1w16z7upNY3=ui1Oi1mZJmaHztiGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 366672652DC
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 14:19:28 +0200 (CEST)
In-Reply-To: <CABnBtVDJQ_0nTLwfFrbMN1w16z7upNY3=ui1Oi1mZJmaHztiGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arun kumar <arun.esd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

arun kumar wrote:
> From the last couple of days, I have been trying to understand the Linux
> Alsa Subsystem.I have read the Alsa Driver API and Application API's. But I
> could not understand the concept of PCM substreams,

A PCM stream has one or more substreams.  Multiple substreams are used when
the hardware can mix them together for one output.  This was used in old
wavetable sound cards; nowadays, you almost always have one substream.


Regards,
Clemens
