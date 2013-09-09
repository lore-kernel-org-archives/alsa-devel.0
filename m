From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help with editing the Raw Midi data with ALSA?
Date: Mon, 09 Sep 2013 10:21:59 +0200
Message-ID: <522D8527.1000007@ladisch.de>
References: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
 <522AF97E.6080105@ladisch.de>
 <CAAVa-AFHigDo2CCZ9+8zrUdVF=EG+FN3sqtMOSH+qCREqTVO2w@mail.gmail.com>
 <CAAVa-AF9vXEAUrN0WuW9vcpdz_5h7eSosaVq-6SMdGyxB653Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 529852610D3
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 10:22:01 +0200 (CEST)
In-Reply-To: <CAAVa-AF9vXEAUrN0WuW9vcpdz_5h7eSosaVq-6SMdGyxB653Ew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ember Autumn Rose Leona <emberleona@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ember Autumn Rose Leona wrote:
> $ gcc -o keyflipd5 KeyFlip.c

You forgot "-lasound".


Regards,
Clemens
