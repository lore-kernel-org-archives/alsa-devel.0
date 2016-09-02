From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecord: does hardware or software throw away
	unused
Date: Fri, 2 Sep 2016 09:01:27 +0200
Message-ID: <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4BB4126724D
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 09:01:28 +0200 (CEST)
In-Reply-To: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> My hardware is putting a stream of MAX_CHANNELS into memory, and firing the
> IRQs on my period boundary with respect to this full MAX_CHANNELS stream.
> [...]
> will arecord see the MAX_CHANNELS in my driver, and use its *software*
> to strip out the upper channels worth of data automatically for me?

Yes.


Regards,
Clemens
