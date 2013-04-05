From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Can DAPM paths span multiple codecs/drivers?
Date: Fri, 05 Apr 2013 15:21:09 +0200
Message-ID: <515ECFC5.5060703@topic.nl>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <20130306105713.GF4896@opensource.wolfsonmicro.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D448@DBDE01.ent.ti.com>
 <5139936D.9080001@topic.nl>
 <B5906170F1614E41A8A28DE3B8D121433ED40278@DBDE01.ent.ti.com>
 <513D96EE.9070003@topic.nl>
 <B5906170F1614E41A8A28DE3B8D121433ED4049D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob10.myregisteredsite.com
 (atl4mhob10.myregisteredsite.com [209.17.115.48])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1DB265FA8
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 15:21:11 +0200 (CEST)
Received: from mail.hostingplatform.com ([10.30.71.204])
 by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r35DLAaR026021
 for <alsa-devel@alsa-project.org>; Fri, 5 Apr 2013 09:21:10 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED4049D@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

If two codecs need each other for certain operations, is there a way to 
define DAPM links between them?

For example, codec A has an analog input "x". It can route this input 
via some output pin to an input of codec B. (In other words, A could be 
a codec that provides an SPDIF output and B could be a codec that can 
only handle digital inputs like the SPDIF from codec A).

Now codec B can record from input "x", but to do so, it would have to 
activate a path leading through codec A. (hence, codec A will need to be 
a bit active)

I have a suspicion that this is possible by hand-crafting some of the 
dapm structs and linking them together. Before I try, I would like to 
know if there's even a possiblity that this will work from folks more 
knowledgable on this topic.

My current implementation is to tell DAPM that i have an "always 
enabled" ADC path and just do everything myself. Which is of course 
wasteful.

Mike.
