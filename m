From: Brian Kaney <brian@vermonster.com>
Subject: Re: ice1712: Card ID problem
Date: Thu, 23 Sep 2004 16:43:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923164319.kcp0de3488w80ckc@webmail.vermonster.com>
References: <20040908203346.GA27226@jose.lug.udel.edu>
	<20040923163649.7xgf4teok0cokcos@webmail.vermonster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040923163649.7xgf4teok0cokcos@webmail.vermonster.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Kaney <brian@vermonster.com>
Cc: ross@jose.lug.udel.edu, alsa-devel@lists.sourceforge.net, bkaney@gmail.com
List-Id: alsa-devel@alsa-project.org

Actually the ID 0x3b152b11 does exist for my card, EWS88D.

So I guess there is some other reason I get neither analog *nor* 
digital output.

Can anyone recommend a card that works "out of the box" with similar features
(i.e. being able to stream in, process/filter and output sound, fully digital
and analog in/out's)?  I really need to get this application to work.

Thanks!
Brian



On Thu, 23 Sep 2004 Brian Kaney <brian@vermonster.com> wrote:

> Okay,  I applied Russ's patch (thanks) after the patches that Dirk
> posted.  Here
> is the output when running envy24control:
>
>
> DEBUG: card_eeprom.subvendor = 3b152b11
> DEBUG: adcIDs: 2, 2, 2, 0
> DEBUG: dacIDs: 1, 1, 1, 2
> mixer.c: pcm_output_channels = 8
> mixer.c: nb_active_channels = 8
> mixer.c: input_channels = 8
> mixer.c: nb_active_channels = 0
> using    --- input_channels: 0
>           --- output_channels: 0
>           --- pcm_output_channels: 8
>           --- spdif in/out channels: 2
>
>
> Looks like my vendor ID is a) missing something (where is the 0x 
> part?) and b)
> also not in the envy24control.h file.
>
> I am a bit over my head here...should I try to cob this vendor id in 
> a similar
> way Dirk posted?
>
> Thanks!
> Brian
>



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
