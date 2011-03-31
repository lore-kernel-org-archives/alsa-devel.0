From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: export pcm_debug_name?
Date: Fri, 01 Apr 2011 12:41:15 +1300
Message-ID: <4D95111B.2090209@audioscience.com>
References: <4D93A9D8.2090104@audioscience.com> <s5htyejzkfz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id D013910381E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 01:41:26 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LIY00FB94GRIJ20@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 01 Apr 2011 12:41:16 +1300 (NZDT)
In-reply-to: <s5htyejzkfz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 31/03/11 22:52, Takashi Iwai wrote:
> At Thu, 31 Mar 2011 11:08:24 +1300,
> Eliot Blennerhassett wrote:
>>
>> Currently  pcm_debug_name is defined locally in pcm_lib.c, this function would be useful
>> for debug output from drivers too?
>>
>> Any objection to exporting this function?
> 
> It's fine to me.  Or, can this be a static inline function?

Thanks Takashi

I'm happy either way. I'd leave it to you and Jaroslav to decide.

BTW Should it become "snd_pcm_debug_name" ?

One thing I'm not sure about is whether this is a debug_only function,
and if so, what to do about the necessary variable required to hold the
name for printing? I.e when debug is turned off, will get warnings about
unused variable "name"

#ifdef CONFIG_SND_DEBUG
static inline pcm_debug_name etc.
#else
#define pcm_debug_name(s,n,l) while (0) do {}
#endif

Typical usage

static int somefunc(struct snd_pcm_substream * substream)
{
#ifdef CONFIG_SND_DEBUG
  char name[16];
#endif

  pcm_debug_name(substream, name, sizeof(name))
  snd_printd("%s foo %d\n", name, other);
  ...
}

Is there a nice way to avoid the #ifdef around name[]?

--
Eliot
