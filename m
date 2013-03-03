From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: amdtp: syt handling
Date: Sun, 03 Mar 2013 16:20:38 +0100
Message-ID: <51336A46.1030305@ladisch.de>
References: <CAOiRfSVz5u866Zv46DKO6DkVkWyn9aVcvLOrMoz1PQyTDVomHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A4F63261734
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 16:21:48 +0100 (CET)
In-Reply-To: <CAOiRfSVz5u866Zv46DKO6DkVkWyn9aVcvLOrMoz1PQyTDVomHw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert von Chamier <whrobbr1986@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Robert von Chamier wrote:
> i am working on the firewire amdtp module. My aim is to add the capture
> functionality. Already in my prototype the module captures up to 192k
> sampling rate.
> But ... How i have to handle the syt in the CIP packages?

By ignoring it:
<http://git.alsa-project.org/?p=alsa-kprivate.git;a=blob;f=sound/firewire/fireworks.c;h=0c7549ab47805d82aab85d3e06baf06180119f66;hb=2a2405fac5f900608eff5ea89926480aad475877#l1239>


Regards,
Clemens
