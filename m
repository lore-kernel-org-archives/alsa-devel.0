From: Bob Ham <node@users.sourceforge.net>
Subject: [Fwd: Re: emu10k1 extin/out options]
Date: 11 Aug 2002 04:12:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1029035560.32578.39.camel@insanity>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>
Cc: "Russ W. Knize" <rknize@ameritech.net>
List-Id: alsa-devel@alsa-project.org

Just realised this should have been cc'd to alsa-devel.

> From: Bob Ham <node@users.sourceforge.net>
> To: Russ W. Knize <rknize@ameritech.net>
> Subject: Re: emu10k1 extin/out options
> Date: 10 Aug 2002 02:54:59 +0100
> 
> On Fri, 2002-08-09 at 17:06, Russ W. Knize wrote:
> > Saw your "notes" addition to the emu10k1 installation document.  Just
> > wanted to go over what you posted (non-5.1), as there may be an
> > inconsistancy in line 8.  Should it be:
> > * Creative Card wo/Digital out + Digital I/O 2  [0x0fc3/0x1f03]
> > 
> > instead of:
> > 
> > * Creative Card wo/Digital out + Digital I/O 2  [0x0fc3/0x1f0f]
> > 
> > Here is what I am able to gather from your post:
> > 
> > Input
> > -----
> > 0xABCD
> > A: Digital I/O 2(?) Off=f, On=0
> > B: LiveDrive Off=0, On=f
> > C: LiveDrive Off=0, On=c
> > D: Digital CD Off=3, On=f
> > 
> > Output
> > ------
> > 0xABCD
> > A: always 1
> > B: always f
> > C: LiveDrive Off=0, On=c
> > D: Digital Out Off=3, On=f
> 
> The wrongness does indeed appear to be there:
> 
>         * Creative Card wo/Digital out + Digital I/O 2  [0x0fc3/0x1f0f]
>         * Creative Card w/Digital out + Digital I/O 2   [0x0fc3/0x1f0f]
> 
> I just copied from the alsa-driver/INSTALL file, tho; I don't know
> anything about it.  Perhaps someone from alsa-devel can help?

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
