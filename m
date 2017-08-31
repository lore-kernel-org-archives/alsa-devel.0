From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Thu, 31 Aug 2017 12:50:10 +0900
Message-ID: <e59f34a8-0999-c552-00e0-3d20a0721d3f@sakamocchi.jp>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
 <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
 <7ef92b65-ef37-1a68-b1d8-e3a747859200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7190726723F
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 05:50:13 +0200 (CEST)
In-Reply-To: <7ef92b65-ef37-1a68-b1d8-e3a747859200@gmail.com>
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
To: "S. Christian Collins" <s.chriscollins@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Aug 29 2017 12:46, S. Christian Collins wrote:
> On 08/28/2017 10:33 PM, Takashi Sakamoto wrote:
>>
>> Would you get output from below command line for your Gina 3G?
>>
>> $ amixer scontrols
> 
> The output of "amixer -c 1 scontrols" is attached to this e-mail as 
> "scontrols.txt".
> 
>> And typically state data is stored into '/var/lib/alsa/asound.state' 
>> as a default. For my information, could you disclose it if possible?
> 
> Yes, it is also attached to this e-mail. The asound.state file was last 
> modified on March 26th. I remember that I used to not get the error when 
> using "alsactl store", so perhaps an update caused this issue to appear 
> around that time?

$ alsactl -f ~/asound1.state store 1
(alsa-utils:alsactl/alsactl.c)
main()
   (alsa-utils:alsactl/state.c)
->save_state()
   ->get_controls()
     ->get_control()
       snd_ctl_elem_info(info)
       count = snd_ctl_elem_info_get_count(info)
       for (i = 0; i < count; i++)
         snd_ctl_elem_value_get_integer(ctl, i)

I guess that 'snd-echo3g.ko' returns value greater than 128 in a call 
graph of 'snd_ctl_elem_info_get_count()', then a call of 
'snd_ctl_elem_value_get_integer()' hits an assertion in the function.

A patch mentioned by Mark Hills (a commit 275353bb684e 'ALSA: echoaudio: 
purge contradictions between dimension matrix members and total number 
of members') is fairly valid in a logical design of ALSA control 
protocol/interface. In detail, please refer to my post[1].

Some of ALSA drivers for PCI cards produced by Echo Audio potentially 
have problems which I mentioned in the post. They can cause 
buffer-over-run over 'struct snd_ctl_elem_value.value' in user space. 
The drivers should be going to fix.

I wrote a small program to validate dimension information for your 
card[2]. Would you please execute it? Like:

$ gcc -o ./test ./alsa-ctl-dimen-check.c
$ ./test /dev/snd/controlC[0-9]

An argument is required for a path of special file for ALSA control 
character device for your sound card.

[1] [alsa-devel] [PATCH 0/3] ALSA: add dimension information validator
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-June/109811.html
[2] alsa-ctl-dimen-check.c
https://gist.github.com/takaswie/cd670ee88b7fd25c68780610ad8ad54f


Regards

Takashi Sakamoto
