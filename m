From: Jannis Achstetter <jannis_achstetter@web.de>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Mon, 24 Sep 2012 10:23:44 +0000 (UTC)
Message-ID: <loom.20120924T122214-841@post.gmane.org>
References: <50587F96.8080005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id F216F2615FB
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 17:50:01 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TGAv6-0000XX-JM
 for alsa-devel@alsa-project.org; Mon, 24 Sep 2012 17:50:04 +0200
Received: from 193.175.21.66 ([193.175.21.66])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 17:50:04 +0200
Received: from jannis_achstetter by 193.175.21.66 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 17:50:04 +0200
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

Colin Fletcher <colin.m.fletcher <at> googlemail.com> writes:

> aconnect simply reports "Connection failed (Input/output error)";
> a2jmidid -e says "ERROR: a2j_port_create: snd_seq_connect_to() for
> 20:0 failed with error -5"; and qjackctl reports no error but refuses
> to make the connection.

I just want to note that the problem is exactly the same with the Edirol UA-101
(uses the same driver) and linux-3.5.3
