From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: help for a levelmeter
Date: Fri, 18 Oct 2002 22:59:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB0762D.5030905@club-internet.fr>
References: <20021015224039.59921.qmail@web12207.mail.yahoo.com>		<3DADC922.5000808@club-internet.fr> <3DAE626C.7601185C@libero.it> <87r8ep9ca1.fsf@sulphur.joq.us> <3DAF2236.EA2A74BD@libero.it> <3DAFD3E9.8090400@club-internet.fr> <3DAFFE44.20CDE90E@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:
> Laurent Georget wrote:
> 
>>
>>Excellent!
>>
>>Well, you wrote  that there is a sample implementation of this pcm_meter ,
>>but I can't find it (searched in alsa tools / utils , and searched  with
>>google with no good result)
>>
>>Anyway, i'm going on trying to use it
> 
> 
> 
> Install alsa-driver, alsa-lib, alsa-oss.
> Insert (adapting it) this in your .asoundrc
> 
> pcm_scope.level {
> 	type level
> }
> 
> pcm_scope_type.level {
> 	lib /u/cvs/alsa/alsa-lib/src/pcm/scopes/.libs/liblevel.so
> }
> 
> pcm.dsp0 {
> 	type meter
> 	slave.pcm 'hw:0,0'
> 	scopes.0 level
> }
> 
> Then try:
> 
> aplay -D dsp0 file.wav
> 
> or the more complex
> 
> aoss realplay /u/music/real/music.rm
> 
> and you'll see amazing things ;-)
> 
> 

Wow!    I got both working !
(give me a bad point for not searching cvs   ;)
		
Now, i can try to make the levelmeter I'm aiming at ( it would be a gtk 
app. ),
with no guarantee about the result  (given my low programming skills)


Thanks a lot

Laurent



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
