From: Jon Ellis <ashura666@mac.com>
Subject: Re: Fwd: arecord bug?
Date: Wed, 19 Mar 2003 18:49:22 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0FFFF579-59F0-11D7-BB3C-0003934489D0@mac.com>
References: <s5hk7ewu7kc.wl@alsa2.suse.de>
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7ewu7kc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday, March 18, 2003, at 10:29  PM, Takashi Iwai wrote:
>
> i guess it reached to 32bit int limit (401*60*4*44100).
> so far, aplay/arecord doesn't support more than size_t max, which is
> 32bit on i386.

Yep, that was my guess too. Is this something anyone is interested in 
fixing?

A couple of ideas:

i) move up to 64bits
ii) start using segments

If anyone who knows the code is interested in working with me i'd be 
happy to help find the right fix. Not sure that i have the time to 
learn the codebase from scratch right now...

Anyone?

j.



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
