From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ctl api questions
Date: Tue, 11 Mar 2003 08:52:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18sk7v-0008O0-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0303111409430.2651-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 11 Mar 2003 14:16:00 +0100."
             <Pine.LNX.4.44.0303111409430.2651-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> Another point: the matrix mixer is now (with patch II from Paul)
>> read/write. In write mode it takes 3 parameters:
>> source,destination,gain. With the amixer patch I submitted some days ago
>> it is possible to actually read it, passing source and destination
>> channels as parameters to the cget option. In the driver, the return
>> values use the same structure as the parameters. Should I respect the
>> parameters index (returning the gain value in value[2]) or should I
>> consider that return values start at value[0] ?
>
>Note that this behaviour is non-standard. You simply moved the addressing 
>outside the sndrv_ctl_elem_id structure which is quite bad in the sense of 
>common API. I think that it would be nice to invent some group controls 
>represented inside the kernel space only with one structure rather than 
>doing things which doesn't follow the API design.

it would be nice, but the last time we discussed this, no viable
solutions emerged, which is why the code still works this way.

ALSA is missing "standard" ways of doing a variety of things, and we
can't not make this functionality available because its in a queue of
other things that need "standardization".

>For example, alsactl doesn't know about your addresing thus is impossible 
>to save and restore the settings of this card via this universal utility.

but amixer+script can. in fact, amixer+script is actually more
flexible than alsactl, and i have to admit that i find it a bit
troubling that both these tools exist. is there something that amixer
cannot do that alsactl can?


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
