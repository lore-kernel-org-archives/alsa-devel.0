From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Sun, 24 May 2015 20:40:14 +0900
Message-ID: <5561B89E.6000608@sakamocchi.jp>
References: <CAJ0eYfWCoqBBLdXpfitc1KZczZmPYXVy9n4-3YEU2Fw0sTRMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC4E260668
 for <alsa-devel@alsa-project.org>; Sun, 24 May 2015 13:40:17 +0200 (CEST)
In-Reply-To: <CAJ0eYfWCoqBBLdXpfitc1KZczZmPYXVy9n4-3YEU2Fw0sTRMNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mike,

Recently, I found some devices which have similar issue as your Orpheus
has and I wrote an patch for it. If possible, would you please test this
branch with your model?

https://github.com/takaswie/snd-firewire-improve/commits/bebob3

About the way to test this repository, please refer to README file.
Then, you need to switch your branch to bebob3, like.
(in your local repository)
$ git checkout bebob3


Regards

Takashi Sakamoto
