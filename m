From: James Wright <james@jigsawdezign.com>
Subject: Re: Moving from OSS to ALSA
Date: Sun, 11 Jan 2004 22:49:39 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040111224939.12a97d36.james@jigsawdezign.com>
References: <20040111181311.7726a5b5.james@jigsawdezign.com>
	<200401120829.54299.lpotter@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401120829.54299.lpotter@trolltech.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Jan 2004 08:29:54 +1000
Lorn Potter <lpotter@trolltech.com> wrote:

> On Monday 12 January 2004 4:13 am, James Wright wrote:
> >  I am currently looking into rewriting our current OSS sound routines to
> > native ALSA, as it seems OSS will invariably be phased out now that the
> > ALSA driver is distrubuted with the Linux kernel, plus ALSA seems to have a
> > great number of benefits for us.
> 
> Personally, I hope OSS compat will never be phased out. Why? OSS is simple, 
> and concise. If I am writing a simple audio recording/playing app, I can get 
> the job done using OSS code in _much_ less lines of code.
> 

  This is true, but for our application (games) we need very low latency, and hence fast
mixing and writes. It now seems pointless using our OSS code if its then going to be 
emulated by ALSA. I'm sure if i stick with ALSA i can get real nice results, its
just a steep learning curve for ALSA n00bs like me...  :(  If I was writing a basic 
audio app with little consideration for latency and efficiency i'd probably have stuck
with OSS and ALSA emulation...

  The main feature i'm interested in is the asychronous pcm playback, it means we can setup 
the sounds mixer, and not have to worry about calling an update_sound() function every 
1/20th of a sec...

> 
> _Dont get me wrong_, ALSA is great and a lot more powerful than OSS, but it is 
> lacking a simple API. 
> Ever try to write an In/Out volume control mixer in OSS? Ever try to port that 
> same mixer to ALSA?  From what I can gather (alsa seems to be lacking mixer 
> docs/tutorial) , the only way to change the mic input level (alsa), I have to 
> enumerate over every mixer gizmo and check to see if its the mic, and then 
> change it if I think it appears to be the Mic.
> 
> Using OSS, I can do that in one line.
> 

   I haven't looked at porting our /dev/mixer routines yet, sounds like its going to be fun!


> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Perforce Software.
> Perforce is the Fast Software Configuration Management System offering
> advanced branching capabilities and atomic changes on 50+ platforms.
> Free Eval! http://www.perforce.com/perforce/loadprog.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
