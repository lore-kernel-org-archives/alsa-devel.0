From: Jon Ellis <ashura666@mac.com>
Subject: Re: Fwd: arecord bug?
Date: Wed, 19 Mar 2003 22:35:17 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <9F3FB2F8-5A0F-11D7-912A-0003934489D0@mac.com>
References: <1048075742.30091.36.camel@lotte>
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048075742.30091.36.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday, March 19, 2003, at 09:08  PM, Justin Cormack wrote:

> On Wed, 2003-03-19 at 09:49, Jon Ellis wrote:
>> On Tuesday, March 18, 2003, at 10:29  PM, Takashi Iwai wrote:
>>>
>>> i guess it reached to 32bit int limit (401*60*4*44100).
>>> so far, aplay/arecord doesn't support more than size_t max, which is
>>> 32bit on i386.
>>
>> Yep, that was my guess too. Is this something anyone is interested in
>> fixing?
>>
>> A couple of ideas:
>>
>> i) move up to 64bits
>> ii) start using segments
>>
>> If anyone who knows the code is interested in working with me i'd be
>> happy to help find the right fix. Not sure that i have the time to
>> learn the codebase from scratch right now...
>
> Have you tried recompiling it with -D_FILE_OFFSET_BITS=64
> -D_LARGEFILE_SOURCE in the CFLAGS? This should just work unless there 
> is
> somethong broken in the code.

i'll give it a try... my suspicion is that it wont work because it's 
the number of... er, frames (? I'm not sure i'm using the correct names 
for things) that is overflowing size_t. I'd be happy to be wrong.

j.



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
