From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Intermittent cut out on the video
Date: Fri, 06 Dec 2013 10:06:51 +0100
Message-ID: <52A193AB.2090202@ladisch.de>
References: <DUB122-W30D40465C0A432A2147375AAEC0@phx.gbl>, , , ,
 <DUB122-W83C8D065397526DB034BAAAEE0@phx.gbl>, , ,
 <5296FEF9.2020604@ladisch.de>, , ,
 <DUB122-W22A2B2F1172BAEC057087BAAEA0@phx.gbl>, , ,
 <DUB122-W150AA077A26EF2F1581D57AAEA0@phx.gbl>, , <529DD914.7060205@ladisch.de>,
 <DUB122-W24AEFB005C0041C03515A7AAD50@phx.gbl>,
 <DUB122-W77AAF5554A9452C7FA642AAD40@phx.gbl>
 <DUB122-W34A0CA20B20786E7B0D210AAD60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B7749261B07
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 10:06:57 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D30B320C21
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 04:06:52 -0500 (EST)
In-Reply-To: <DUB122-W34A0CA20B20786E7B0D210AAD60@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dolevo Jay <cmst@live.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dolevo Jay wrote:
> I have come to conclusion that this issue is way more complex that I
> thought and won't be "possible" to implement even with the help of
> pulseaudio

Doesn't module-combine-sink work?

> What I don't understand, ok one of the sound card gets drifted over
> time if two sound cards are employed in the system and therefore I got
> cut outs but why doesn't this happen if I use the same sound card
> alone?

The playback speed is determined by the hardware, not by the
application.  When an application tries to write more data than is
currently possible, ALSA will just wait.

This does not work if the playback is coming in real time from a source
whose speed you cannot control, such as an S/PDIF input or broadcasting
TV.  In that case, you eventually get the same problem.


Regards,
Clemens
