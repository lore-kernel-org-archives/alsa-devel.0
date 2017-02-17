From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help with midi player application
Date: Fri, 17 Feb 2017 17:12:57 +0100
Message-ID: <010aad38-9842-7aad-f8b3-3956a76ec8ef@ladisch.de>
References: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
 <4c95ab4d-55a8-bbc7-f758-7022ab800440@ladisch.de>
 <BN6PR05MB3009240F07BF616C635EA8ABD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2412671DB
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 17:12:59 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 96B9F55831DD
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 17:12:58 +0100 (CET)
In-Reply-To: <BN6PR05MB3009240F07BF616C635EA8ABD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
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

amidi@LEFerguson.com wrote:
> I took the technique from what pmidi did

AFAICS pmidi uses absolute timestamps.

> But that said I don't think it is hard to do the running calculations
> and change it, if you think there's merit?

There appears to be a problem with timestamps.  I don't know
where (I haven't seen your calculations).  You have mentioned
only snd_seq_ev_schedule_tick(), so that is the only one I
can suggest to change.

> Is there any way to query the queue for what is in it?

No.


Regards,
Clemens
