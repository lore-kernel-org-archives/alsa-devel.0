From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/9] R3Di and SBZ quirk entires + alt
	firmware loading
Date: Fri, 4 May 2018 17:25:58 +0900
Message-ID: <2d719f92-805a-77bb-dd3e-34c3e1e26940@sakamocchi.jp>
References: <1525407594-25644-1-git-send-email-conmanx360@gmail.com>
 <CAM8Agx0s1Rg5bGCXP5gQftcfsqbQoCvZtNyg4fmUpNaJsix=-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6C051267235
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 10:26:12 +0200 (CEST)
In-Reply-To: <CAM8Agx0s1Rg5bGCXP5gQftcfsqbQoCvZtNyg4fmUpNaJsix=-A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On May 04 2018 13:30, Connor McAdams wrote:
> Sorry for sending these twice, I made a formatting mistake in the
> first series, and they would not apply properly. Hopefully these do
> not show up as spam because of this.
> 
> I went through and fixed them all individually and re-committed them,
> but kept the same commit messages. I still have a lot to learn.

For this case, please use '--subject-prefix' option for 
git-format-patch. Like:

$ git format-patch --subject-prefix='PATCH v2'


Additionally, it's preferable to add 'ALSA: hda/ca0132: ' prefix for 
each patch. Like:

'ALSA: hda/ca0132: R3Di and SBZ quirk entires + alt firmware loading'


Furthermore, when posting several patches as a one series, it's 
preferable to post cover letter as well. Like:

$ git format-patch --cover-letter
0000-cover-letter.patch
...

Of course, it's better to write enough information in the cover letter. 
For its content, please refer to cover letters by the other developers 
in alsa-devel archive.
http://mailman.alsa-project.org/pipermail/alsa-devel/


Thanks

Takashi Sakamoto
