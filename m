From: Tim Goetze <tim@quitte.de>
Subject: [ot] Re: Testers of M-Audio Delta/Audiophile cards
 wanted
Date: Mon, 23 Sep 2002 16:43:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209231438370.573-100000@summer.quitte>
References: <3D8AE57A.D59A47DF@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D8AE57A.D59A47DF@ladisch.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>Tim Goetze wrote:
>> Takashi Iwai wrote:
>> 
>> >At Thu, 19 Sep 2002 17:06:08 +0200 (CEST),
>> >Tim Goetze wrote:
>> >>
>> >> much simpler. you did a c++ style auto variable allocation, declare
>> >> 'ak' at the start of snd_ice1712_ews_init and it compiles cleanly.
>> >
>> >oops, never noticed that.  i relied too much upon the compiler.
>> >well, this means that gcc-3.2 accepts this style as normal C...?
>> 
>> strange that 3.2 isn't ANSI C compliant here.
>
>3.2 _is_ ANSI C compliant here. ("ANSI C" being C99 in this case :-)

makes me look forward to writing

  try {
    pcm = new ALSA::PCM ("hw:0,0");
    ...

when C05 is here. 

;) tim




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
