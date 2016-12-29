From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH] Revert
 "ASoC: core: replace aux_comp_list to component_dev_list"
Date: Thu, 29 Dec 2016 17:30:09 +0100
Message-ID: <322a0777-d58f-a776-1c9a-b14dad127e15@samsung.com>
References: <CGME20161229152622epcas4p19054a78722d5eae88c983230f457e794@epcas4p1.samsung.com>
 <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
 <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
 <92ff85cb-ba21-07b8-c26c-a86de73b786f@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <92ff85cb-ba21-07b8-c26c-a86de73b786f@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/29/2016 05:20 PM, Nikita Yushchenko wrote:
> I believe aux devices are on both lists.

Indeed, you are right, they are on both lists.
So there should be no issues after reverting.
