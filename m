From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: dmix bugs. sounds very broken up.
Date: Tue, 02 Sep 2003 12:50:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F548405.80902@superbug.demon.co.uk>
References: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz> <3F53D15B.3090507@superbug.demon.co.uk> <Pine.LNX.4.53.0309021232410.29300@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309021232410.29300@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 2 Sep 2003, James Courtier-Dutton wrote:
> 
> 
>>Jaroslav Kysela wrote:
>>
>>>On Mon, 1 Sep 2003, James Courtier-Dutton wrote:
>>>
>>>
>>>
>>>>I have found two problems with using the dmix alsa device name.
>>>>1) snd_pcm_hw_params_can_pause (params)  causes alsa-lib to assert!
>>>>
>>>>2) Sound is broken up.
>>>>a) It can only function with 2 periods, why is that? Having 8 periods
>>>>might be better, although "front" works fine with 2 periods, but "dmix"
>>>>with 2 periods fails.
>>
>>See attachment dmix-fail.c
>>compile with
>>gcc -g -DDEBUG -lasound a.c
>>
>>Shows problem (1) and (2)
> 
> 
> (1)
> 
> The count of used periods is probably 2.73 for 64kB buffer, my setup is:
> 
> buffer_size  : 16384
> period_size  : 6000
> 
> If you want another setup, you must write your own configuration to
> ~/.asoundrc.
> 
> (2)
> 
> Problem with uninitialized pcm->info value is fixed in CVS.
> 
> 
>>>>b) Of the 2 periods, it sounds like sound is only being played from one
>>>>of the periods, with silence for the other period.
>>>>
>>
>>I don't have a small compilable example for this yet. The problem
>>application is the latest xine cvs. (xine.sf.net)
> 
> 
> Note that it might be caused that your code is broken. Please, use the
> correct transfer unit (period_size) and not the period count which might
> be a real not integer value, thus buffer_size / period_size !=
> integer(period_count).
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
The aim of my code is to try for a buffer that is about 1 second long or 
less, and has hopefully 8 periods.
I had always assumed that the period_count had to be an integer.
If it is in fact possible to to have the period_count a non-interger on 
all sound cards, then I will change my code.

The problem with trying the period_size approach was: -
set_buffer_time_near(1 second)
size = get_buffer_size()  (e.g. this gets set to 16384)
set_period_size_near(size/8, dir=0)  (e.g. try to set period_size to 
2048) <- Failed on some cards/devices that did not like 8 periods.

I thought that set_period_size_near with a dir=0, should have resulted 
in a setting of 6000 for "dmix", but it in-fact failed, and I did not 
want to go round a loop trying different period sizes until one worked.

Does this point to a bug in the set_period_size_near function then?

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
