From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: help for a levelmeter
Date: Fri, 18 Oct 2002 14:27:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAFFE44.20CDE90E@libero.it>
References: <20021015224039.59921.qmail@web12207.mail.yahoo.com>		<3DADC922.5000808@club-internet.fr> <3DAE626C.7601185C@libero.it> <87r8ep9ca1.fsf@sulphur.joq.us> <3DAF2236.EA2A74BD@libero.it> <3DAFD3E9.8090400@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Laurent Georget <lgeorget2@club-internet.fr>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Laurent Georget wrote:
> 
> 
> Excellent!
> 
> Well, you wrote  that there is a sample implementation of this pcm_meter ,
> but I can't find it (searched in alsa tools / utils , and searched  with
> google with no good result)
> 
> Anyway, i'm going on trying to use it


Install alsa-driver, alsa-lib, alsa-oss.
Insert (adapting it) this in your .asoundrc

pcm_scope.level {
	type level
}

pcm_scope_type.level {
	lib /u/cvs/alsa/alsa-lib/src/pcm/scopes/.libs/liblevel.so
}

pcm.dsp0 {
	type meter
	slave.pcm 'hw:0,0'
	scopes.0 level
}

Then try:

aplay -D dsp0 file.wav

or the more complex

aoss realplay /u/music/real/music.rm

and you'll see amazing things ;-)


-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
