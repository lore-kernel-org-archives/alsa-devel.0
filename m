From: Jon Ellis <ashura666@mac.com>
Subject: Re: Fwd: arecord bug?
Date: Thu, 20 Mar 2003 07:46:49 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ABFF2500-5A5C-11D7-99E3-0003934489D0@mac.com>
References: <s5hu1dzs9e6.wl@alsa2.suse.de>
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=ISO-2022-JP; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1dzs9e6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Justin Cormack <justin@street-vision.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday, March 19, 2003, at 11:45  PM, Takashi Iwai wrote:

> At Wed, 19 Mar 2003 22:35:17 +0900,
> Jon Ellis wrote:
>>
>> i'll give it a try... my suspicion is that it wont work because it's
>> the number of... er, frames (? I'm not sure i'm using the correct 
>> names
>> for things) that is overflowing size_t. I'd be happy to be wrong.
>
> it's the count in bytes.
>
> anyway, i fixed the relevant part on cvs.
> now arecord allows you to capture the unlimited size in the raw mode.
> i've not tested this yet (no time :)

I'll get on the testing part and let you know if i can fill my disk ;-)

> also fixed a bug in the capture to stdout in WAV mode.
> it's restricted to 32bit signed int due to the RIFF chunk.  it would
> be possible to record longer than creating more chunks but arecord
> doesn't do that (yet).

Cool.

お力添えありがとうございます。 :-)

j.



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
