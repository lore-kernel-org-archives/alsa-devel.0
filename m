From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 12:11:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EACFE4A.5070300@libero.it>
References: <Pine.LNX.4.44.0304281110360.1603-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304281110360.1603-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
> On Mon, 28 Apr 2003, Abramo Bagnara wrote:
> 
> 
>>Jeremy Hall ha scritto:
>>
>>>Will this fix allow both CPUs to run snd_pcm_period_elapsed() and friends 
>>>concurrently and then if XRUN is encountered grab the group lock, or will 
>>>one stream run at a time, in effect only allowing one card to process at a 
>>>time?
>>
>>As I've pointed to Jaroslav, current CVS code does not permit to both 
>>CPUs to run the interrupt handler of two linked streams concurrently.
>>
>>This is due to unconditional substitution of stream specific lock with a 
>>linked group lock.
>>
>>This is of course deadlock safe, but I think it's not the right solution.
> 
> 
> Sure, it was 1st version ;-)

Your missed answer to my objections made me suspected that ;-)

> It seems a bit complicated to me. We can do easy this block:
> 
> read_lock(link_manager);
> spin_lock(stream);
> ....
> if (stream_in_group)
>    spin_lock(group);
> ....
> if (stream_in_group)
>    spin_unlock(group);
> ....
> spin_unlock(stream);
> read_unlock(link_manager);
> 
> I cannot imagine any deadlock with this locking scheme, because stream 
> locks are independent now.

CPU1:

read_lock(link_manager);	read_lock(link_manager);
spin_lock(s1);			spin_lock(s2);
if (stream_in_group)		if (stream_in_group)
	spin_lock(group);		spin_lock(group); /* Waiting */
spin_lock(s2); /* BOOM! */

I guess that 3rd version will be the one I propose ;-)

(but probably the right one will be the forthcoming 4th)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
