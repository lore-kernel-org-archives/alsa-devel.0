From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: incomplete type?!?
Date: Mon, 10 Mar 2003 17:33:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030310173336.pochini@shiny.it>
References: <s5h7kb75o8o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kb75o8o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 10-Mar-2003 Takashi Iwai wrote:
> At 06 Mar 2003 22:46:45 +0000,
> Giuliano Pochini wrote:
>>
>> I can't compile spin_lockxxxx(lock):
>>
>> echoaudio.c:237: dereferencing pointer to incomplete type
>>
>> I try to compile my module with the same args, defines and includes of
>> azt3328.c. Spinlock operations expands to exactly the same stuff
>> according cpp, but azt3328 compiles fine. What am I missing ?
>
> did you include the correct kernel header files?
> i guess spinlock_t is not defined properly.

Yes... I believe. I also copied the #include's from azt3328.c and
I added <spinlock.h>. I hate problems with header files #:(


Bye.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
