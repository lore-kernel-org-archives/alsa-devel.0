From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Tue, 18 Sep 2012 16:23:38 +0200
Message-ID: <505883EA.6070808@ladisch.de>
References: <50587F96.8080005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9ADF42650B1
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 16:23:41 +0200 (CEST)
In-Reply-To: <50587F96.8080005@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Fletcher <colin.m.fletcher@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Fletcher wrote:
> I've just recently noticed that connections to the MIDI output of my
> Edirol UA-1000 fail when using the snd_ua101 driver in recent kernels.
>
> aconnect simply reports "Connection failed (Input/output error)";
> a2jmidid -e says "ERROR: a2j_port_create: snd_seq_connect_to() for
> 20:0 failed with error -5"

Are there any error messages in the system log?


Regards,
Clemens
