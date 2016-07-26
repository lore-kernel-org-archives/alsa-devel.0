From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: v1.1.2 release?
Date: Tue, 26 Jul 2016 16:07:43 +0900
Message-ID: <57970C3F.5040303@sakamocchi.jp>
References: <s5hfuqyt4xo.wl-tiwai@suse.de>
 <7f0d3e5b-a665-11d6-f1cb-50e86aa46669@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7650F261B01
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 09:07:46 +0200 (CEST)
In-Reply-To: <7f0d3e5b-a665-11d6-f1cb-50e86aa46669@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav and Iwai-san,

On Jul 26 2016 15:57, Jaroslav Kysela wrote:
> Dne 25.7.2016 v 11:58 Takashi Iwai napsal(a):
>> Hi Jaroslav,
>>
>> shall we release v1.1.2 along with 4.7 kernel?  We've got already a
>> bunch of changes in alsa-lib and co.
>
> Hi,
>
>    yes, I plan to prepare the new release this week.

In this release, I added five APIs newly:
  * snd_ctl_elem_info_set_dimension()
  * snd_ctl_add_integer_elem_set()
  * snd_ctl_add_integer64_elem_set()
  * snd_ctl_add_boolean_elem_set()
  * snd_ctl_add_enumerated_elem_set()
  * snd_ctl_add_bytes_elem_set()

In this case, on usual way to maintain library, as long as I know, minor 
version is going to be incremented, instead of micro version. In short, 
to v1.2.0.

But I committed assuming v1.1.2. For example:
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/control/control.c;h=6c00b8e50d2be78f9c5e93322b8e8b107ff8c442;hb=HEAD#l2533

If it's going to be versioned to v1.2.0, please tell it to me. I'll post 
a patch to fix my commits in time of your release work.


Thanks

Takashi Sakamoto
